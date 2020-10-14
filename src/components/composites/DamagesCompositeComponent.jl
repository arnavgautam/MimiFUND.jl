include("../ImpactAgricultureComponent.jl")
include("../ImpactBioDiversityComponent.jl")
include("../ImpactCardiovascularRespiratoryComponent.jl")
include("../ImpactCoolingComponent.jl")
include("../ImpactDiarrhoeaComponent.jl")
include("../ImpactExtratropicalStormsComponent.jl")
include("../ImpactForestsComponent.jl")
include("../ImpactHeatingComponent.jl")
include("../ImpactVectorBorneDiseasesComponent.jl")
include("../ImpactTropicalStormsComponent.jl")
include("../VslVmorbComponent.jl")
include("../ImpactDeathMorbidityComponent.jl")
include("../ImpactWaterResourcesComponent.jl")
include("../ImpactSeaLevelRiseComponent.jl")
include("../ImpactAggregationComponent.jl")

@defcomposite damagescomposite begin
    
    Component(impactagriculture)
    Component(impactbiodiversity)
    Component(impactcardiovascularrespiratory)
    Component(impactcooling)
    Component(impactdiarrhoea)
    Component(impactextratropicalstorms)
    Component(impactforests)
    Component(impactheating)
    Component(impactvectorbornediseases)
    Component(impacttropicalstorms)
    Component(vslvmorb)
    Component(impactdeathmorbidity)
    Component(impactwaterresources)
    Component(impactsealevelrise)
    Component(impactaggregation)

    gdp90 = Parameter(impactagriculture.gdp90, impactcooling.gdp90, impactdiarrhoea.gdp90, impactextratropicalstorms.gdp90, impactforests.gdp90, impactheating.gdp90, impactvectorbornediseases.gdp90, impacttropicalstorms.gdp90, impactwaterresources.gdp90)
    cumaeei = Parameter(impactcooling.cumaeei, impactheating.cumaeei)
    pop90 = Parameter(impactagriculture.pop90, impactcooling.pop90, impactdiarrhoea.pop90, impactextratropicalstorms.pop90, impactforests.pop90, impactheating.pop90, impactvectorbornediseases.pop90, impacttropicalstorms.pop90, impactwaterresources.pop90)
    acco2 = Parameter(impactagriculture.acco2, impactextratropicalstorms.acco2, impactforests.acco2)
    income = Parameter(impactagriculture.income, impactbiodiversity.income, impactcooling.income, impactdiarrhoea.income, impactextratropicalstorms.income, impactforests.income, impactheating.income, impactvectorbornediseases.income, impacttropicalstorms.income, vslvmorb.income, impactwaterresources.income, impactsealevelrise.income, impactaggregation.income)
    population = Parameter(impactagriculture.population, impactbiodiversity.population, impactcardiovascularrespiratory.population, impactcooling.population, impactdiarrhoea.population, impactextratropicalstorms.population, impactforests.population, impactheating.population, impactvectorbornediseases.population, impacttropicalstorms.population, vslvmorb.population, impactdeathmorbidity.population, impactwaterresources.population, impactsealevelrise.population)
    temp = Parameter(impactagriculture.temp, impactbiodiversity.temp, impactcardiovascularrespiratory.temp, impactcooling.temp, impactforests.temp, impactheating.temp, impactvectorbornediseases.temp, impactwaterresources.temp)
    co2pre = Parameter(impactagriculture.co2pre, impactextratropicalstorms.co2pre, impactforests.co2pre)


    connect(impactdeathmorbidity.vsl, vslvmorb.vsl)
    connect(impactdeathmorbidity.vmorb, vslvmorb.vmorb)
    connect(impactdeathmorbidity.dengue, impactvectorbornediseases.dengue)
    connect(impactdeathmorbidity.schisto, impactvectorbornediseases.schisto)
    connect(impactdeathmorbidity.malaria, impactvectorbornediseases.malaria)
    connect(impactdeathmorbidity.cardheat, impactcardiovascularrespiratory.cardheat)
    connect(impactdeathmorbidity.cardcold, impactcardiovascularrespiratory.cardcold)
    connect(impactdeathmorbidity.resp, impactcardiovascularrespiratory.resp)
    connect(impactdeathmorbidity.diadead, impactdiarrhoea.diadead)
    connect(impactdeathmorbidity.hurrdead, impacttropicalstorms.hurrdead)
    connect(impactdeathmorbidity.extratropicalstormsdead, impactextratropicalstorms.extratropicalstormsdead)
    connect(impactdeathmorbidity.diasick, impactdiarrhoea.diasick)

    # TODO: Refactor impactaggregation
    connect(impactaggregation.heating, impactheating.heating)
    connect(impactaggregation.cooling, impactcooling.cooling)
    connect(impactaggregation.agcost, impactagriculture.agcost)
    connect(impactaggregation.species, impactbiodiversity.species)
    connect(impactaggregation.water, impactwaterresources.water)
    connect(impactaggregation.hurrdam, impacttropicalstorms.hurrdam)
    connect(impactaggregation.extratropicalstormsdam, impactextratropicalstorms.extratropicalstormsdam)
    connect(impactaggregation.forests, impactforests.forests)
    connect(impactaggregation.drycost, impactsealevelrise.drycost)
    connect(impactaggregation.protcost, impactsealevelrise.protcost)
    connect(impactaggregation.entercost, impactsealevelrise.entercost)
    connect(impactaggregation.deadcost, impactdeathmorbidity.deadcost)
    connect(impactaggregation.morbcost, impactdeathmorbidity.morbcost)
    connect(impactaggregation.wetcost, impactsealevelrise.wetcost)
    connect(impactaggregation.leavecost, impactsealevelrise.leavecost)

    landloss = Variable(impactsealevelrise.landloss)
    enter = Variable(impactsealevelrise.enter)
    leave = Variable(impactsealevelrise.leave)
    dead = Variable(impactdeathmorbidity.dead)
    eloss = Variable(impactaggregation.eloss)
    sloss = Variable(impactaggregation.sloss)

end