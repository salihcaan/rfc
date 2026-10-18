workspace "Seller Support Platform" "C4 model for compensation, seller data and tickets." {

    !identifiers hierarchical
    !adrs ../domains/compensation/adr

    model {
        agent = person "Support Agent" "Handles seller tickets."
        sellerOps = person "Seller Ops" "Monitors seller compensation issues."
        seller = person "Seller" "Sells on the marketplace."

        finance = softwareSystem "Finance" "Pays out compensations." "External"

        platform = softwareSystem "Seller Support Platform" {
            tickets = container "ticket-service" "Ticket lifecycle; writes TicketClosed to outbox." "Java / Spring"
            ticketsDb = container "tickets DB" "Tickets + outbox." "PostgreSQL" "Database"
            kafka = container "Kafka" "Event backbone." "Kafka" "Queue"
            compWorker = container "comp-worker" "Calculates compensations from TicketClosed." "Java / Spring"
            compDb = container "comp DB" "compensation_calculation." "PostgreSQL" "Database"
            sellerData = container "seller-data" "Seller profile and contract." "Go"
        }

        agent -> platform.tickets "Closes tickets"
        platform.tickets -> platform.ticketsDb "Reads/writes, outbox in same tx"
        platform.tickets -> platform.kafka "Relays TicketClosed" "tickets.ticket-closed.v1"
        platform.kafka -> platform.compWorker "Delivers TicketClosed"
        platform.compWorker -> platform.sellerData "Fetches contract" "HTTP"
        platform.compWorker -> platform.compDb "Stores calculations"
        finance -> platform.compDb "Reads ACTIVE calculations" "batch"
        sellerOps -> platform.compWorker "Receives DLQ alerts"
        seller -> finance "Gets paid by"
    }

    views {
        systemContext platform "Context" {
            include *
            autolayout lr
        }
        container platform "Containers" {
            include *
            autolayout lr
        }
        dynamic platform "AsyncCompensation" "RFC-042 flow" {
            agent -> platform.tickets "Close ticket (compensate)"
            platform.tickets -> platform.kafka "TicketClosed via outbox"
            platform.kafka -> platform.compWorker "Consume"
            platform.compWorker -> platform.sellerData "Get contract"
            platform.compWorker -> platform.compDb "Insert ACTIVE calculation"
            autolayout lr
        }
        styles {
            element "Element" { background #1168bd color #ffffff shape RoundedBox }
            element "Person" { background #08427b shape Person }
            element "Database" { shape Cylinder }
            element "Queue" { shape Pipe }
            element "External" { background #999999 }
        }
    }
}
