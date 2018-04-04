input {

}

datasources {
    ups = DataSource.UPS.retrieveByUUID(inputField(1))
}

output {
    input(1)
            .transform
    addFields(
    )
}

