# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.create([
    {
        type: "highlight",
        question: "Highlight the primary claim made in this article."
    },
    {
        type: "highlight",
        question: "Highlight the evidence given for the primary claim?"
    },
    {
        type: "text",
        question: "How convincing do you find the evidence? Why?"
    },
    {
        type: "highlight",
        question: "Highlight where the author cites other sources."
    },
    {
        type: "text",
        question: "How credible is each of the sources?"
    },
    {
        type: "text",
        question: "Does the article properly characterize the methods and conclusions of the sources?"
    }

])

Article.create([
    {
        topic: `health`,
        subtopic: `vaccines`,
        title: `Johns Hopkins Researcher Releases Shocking Report On Flu Vaccines`,
        metadata: `ewao.com`,
        content: ` 
        `,
        expert_score: 2
    },
    {
        topic: `climate change`,
        subtopic: `flooding`,
        title: `"Floods in India, Bangladesh and Nepal kill 1,200 and leave millions homeless"`,
        metadata: `independent.co.uk`,
        content: ` 
        `,
        expert_score: 3
    },
    {
        topic: `health`,
        subtopic: `nutrition`,
        title: `Coconut oil isn't healthy. It's never been healthy.`,
        metadata: `usatoday.com`,
        content: ` 
        `,
        expert_score: 3
    },
    {
        topic: `health`,
        subtopic: ``,
        title: `How Your Finger Shape Determines Your Personality (And Your Health Risks)`,
        metadata: `mysticalraven.com`,
        content: ` 
        `,
        expert_score: 1
    },
    {
        topic: `health`,
        subtopic: `vaccines`,
        title: `FDA Announced That Vaccines Are Causing Autism!`,
        metadata: `inshapetoday.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Monsanto Is Scrambling To Bury This Breaking Story - Don't Let This Go Unshared!`,
        metadata: `foodbabe.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `"CONFIRMED: E-CIGARETTES CAUSE A HORRIBLE INCURABLE DISEASE CALLED äó_""POPCORN LUNGäó_"". WORSE THAN LUNG CANCER!"`,
        metadata: `nowcheckthis.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `climate change`,
        subtopic: `polar ice`,
        title: `"There are diseases hidden in ice, and they are waking up"`,
        metadata: `bbc.com`,
        content: ` 
        `,
        expert_score: 3
        },
        {
        topic: `health`,
        subtopic: `kids/moms`,
        title: `Mom's warning is spreading like wildfire - scented candles are harmful to your babyäó_í‹íÇshealth`,
        metadata: `newsner.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Resorts in Mexico suspected of drugging tourists`,
        metadata: `wfaa.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `Hand-Foot-And-Mouth Disease On The Rise: Experts Beg Parents To Know The Signs`,
        metadata: `littlethings.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: `vaccines`,
        title: `"Lead Developer of HPV Vaccines Comes Clean, Warns Parents & Young Girls Itäó_í‹íÇs All A Giant Deadly Scam"`,
        metadata: `alternativenewsnetwork.net`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: `conspiracy`,
        title: `MISSION IMPOSSIBLE: Official story of Las Vegas shooting unravels; physical impossibility of lone gunman senior citizen makes narrative ludicrous`,
        metadata: `naturalnews.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: `nutrition`,
        title: `Health Experts Are Warning People To Stop Eating Tilapia`,
        metadata: `androidmagazines.info`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Stop holding your farts in. Here are 7 unexpectedhealth benefits of passing gas`,
        metadata: `shareably.net`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `climate change`,
        subtopic: `energy`,
        title: `Tesla made more money last quarter than the entire US oil industry made last year`,
        metadata: `electrek.co`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: `nutrition`,
        title: `"Drinking more coffee can lead to a longer life, new studies say"`,
        metadata: `cnn.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Putting Kids To Bed Early Improves Mom's Health`,
        metadata: `simplemost.com`,
        content: ` 
        `,
        expert_score: 3
        },
        {
        topic: `"climate change, health"`,
        subtopic: `agriculture`,
        title: `Substituting Beans for Beef Would Help the U.S. Meet Climate Goals`,
        metadata: `theatlantic.com`,
        content: ` 
        `,
        expert_score: 3.5
        },
        {
        topic: `health`,
        subtopic: `nutrition`,
        title: `WITH ONLY 2 CUPS A DAY FOR 1 WEEK YOUR STOMACH WILL BE FLATTER! - Public HealthABC`,
        metadata: `publichealthabc.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `9 sleeping positions to improve your health and life`,
        metadata: `ntd.tv`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `climate change`,
        subtopic: `flooding`,
        title: `Hurricane Harvey: Houston's flooding made worse by unchecked urban development and wetland destruction`,
        metadata: `qz.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `"Malignant narcisissm': Donald Trump displays classic traits of mental illness, claim psychologists"`,
        metadata: `independent.co.uk`,
        content: ` 
        `,
        expert_score: 3.5
        },
        {
        topic: `health`,
        subtopic: `vaccines`,
        title: `Vaccinated vs. Unvaccinated: Mawson Homeschooled Study Reveals Who is Sicker`,
        metadata: `cmsri.org`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Dancing can reverse the signs of aging in the brain`,
        metadata: `medicalxpress.com`,
        content: ` 
        `,
        expert_score: 5
        },
        {
        topic: `health`,
        subtopic: `nutrition`,
        title: `"PLS SHARE: DO NOT EAT THIS FISH, IT IS VERY DANGEROUS FOR YOUR HEALTH!"`,
        metadata: `nationspressph.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `"Preventing Alzheimer's Disease, Dementia & Cognitive Decline With Diet"`,
        metadata: `dailyhealthpost.com`,
        content: ` 
        `,
        expert_score: 3
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `Six Pharmaceutical Drugs That Immediately Destroy Your Health`,
        metadata: `ewao.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: `political`,
        title: `"Under the GOP's health plan, sexual assault could be considered a pre-existing condition"`,
        metadata: `mic.com`,
        content: ` 
        `,
        expert_score: 3
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `World Renowned Heart Surgeon Speaks Out On What Really Causes Heart Disease`,
        metadata: `dailyoccupation.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `The Best Exercise for Aging Muscles`,
        metadata: `nytimes.com`,
        content: ` 
        `,
        expert_score: 5
        },
        {
        topic: `climate change`,
        subtopic: `polar ice`,
        title: `Arctic stronghold of worldäó_í‹íÇs seeds flooded after permafrost melts`,
        metadata: `theguardian.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: `kids/moms`,
        title: `Birth order: First-borns get intellectual advantage`,
        metadata: `today.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `climate change`,
        subtopic: `polar ice`,
        title: `DELINGPOLE: Global Warming Study Cancelled Because of 'Unprecedented' Ice`,
        metadata: `breitbart.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `"The boy with very rare 'aging disease', Sam Berns dies at 17 - he inspired millions!"`,
        metadata: `ntd.tv`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: ``,
        title: `"So Coconut Oil Is Actually Really, Really Bad For You"`,
        metadata: `iflscience.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `"Surgeon General Vivek Murthy: Addiction Is A Chronic Brain Disease, Not A Moral Failing"`,
        metadata: `huffingtonpost.com`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `health`,
        subtopic: `disease`,
        title: `Stop Calling Your Drug Addiction a Disease`,
        metadata: `awarenessact.com`,
        content: ` 
        `,
        expert_score: 1
        },
        {
        topic: `health`,
        subtopic: `conspiracy`,
        title: `Five things that just donäó_í‹íÇt add up about the Las Vegas mass shooting`,
        metadata: `naturalnews.com`,
        content: ` 
        `,
        expert_score: 2
        },
        {
        topic: `health`,
        subtopic: `kids/moms`,
        title: `Dirt Is Good': New Book Explores Why Kids Should Be Exposed To Germs : Shots`,
        metadata: `npr.org`,
        content: ` 
        `,
        expert_score: 4
        },
        {
        topic: `climate change`,
        subtopic: `polar ice`,
        title: `An Iceberg the Size of Delaware Just Broke Away From Antarctica`,
        metadata: `nytimes.com`,
        content: ` 
        `,
        expert_score: 5
        },
        {
        topic: `climate change`,
        subtopic: `flooding`,
        title: `"Heavy Monsoon Causing Extreme Flooding In South Asia Has Killed 1,200 People So Far"`,
        metadata: `iflscience.com`,
        content: ` 
        `,
        expert_score: 3
        },
        {
        topic: `climate change`,
        subtopic: `polar ice`,
        title: `Arctic's Winter Sea Ice Drops to Its Lowest Recorded Level`,
        metadata: `nytimes.com`,
        content: ` 
        `,
        expert_score: 4.5
        },
        {
        topic: `undefined`,
        subtopic: `undefined`,
        title: `undefined`,
        metadata: `undefined`,
        content: ` 
        `,
        expert_score: undefined
        }
  
])

