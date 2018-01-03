﻿using Mimi

@defcomp impactbiodiversity begin
    regions = Index()

    # Change in number of species in relation to the year 2000
    biodiv = Variable(index=[time])

    species = Variable(index=[time,regions])

    # Number of species in the year 2000
    nospecbase = Parameter()

    nospecies = Parameter(index=[time])
    temp = Parameter(index=[time,regions])
    income = Parameter(index=[time,regions])
    population = Parameter(index=[time,regions])
    valinc = Parameter(index=[regions])
    bioshare = Parameter()
    spbm = Parameter()
    valbase = Parameter()
    dbsta = Parameter()
end

function run_timestep(s::impactbiodiversity, t::Int)
    v = s.Variables
    p = s.Parameters
    d = s.Dimensions

    if t>1
        v.biodiv[t] = p.nospecbase / p.nospecies[t]

        for r in d.regions
            ypc = 1000.0 * p.income[t, r] / p.population[t, r]

            dt = abs(p.temp[t, r] - p.temp[t - 1, r])

            valadj = p.valbase / p.valinc[r] / (1 + p.valbase / p.valinc[r])

            v.species[t, r] = p.spbm /
                            p.valbase * ypc / p.valinc[r] / (1.0 + ypc / p.valinc[r]) / valadj * ypc *
                            p.population[t, r] / 1000.0 *
                            dt / p.dbsta / (1.0 + dt / p.dbsta) *
                            (1.0 - p.bioshare + p.bioshare * v.biodiv[t])
        end
    end
end
