# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
    {
        name: "Margot",
        key: "seed1"
    },
    {
        name: "Suzy",
        key: "seed2"
    },
    {
        name: "Jisu",
        key: "seed3"
    },
    {
        name: "Woosung",
        key: "seed4"
    },
    {
        name: "Hodol",
        key: "seed5"
    }
]);

Task.create([
    {
        kind: "option",
        question: "Is the headline clickbaity?",
        options: "Very much clickbaity, Somewhat clickbaity, A little bit clickbaity, Not at all clickbaity"
    },
    {
        kind: "highlight",
        question: "What is the primary claim made in this article?"
    },
    {
        kind: "verify",
        question: "Verify the primary claim made in this article."
    },
    {
        kind: "highlight",
        question: "What evidence is given for the primary claim?"
    },
    {
        kind: "verify",
        question: "Verify the evidence."
    },
    {
        kind: "option",
        question: "How convincing do you find the evidence?",
        options: "Very convincing, Somewhat convincing, Somewhat not convincing, Not at all convincing"
    },
    {
        kind: "option",
        question: "Does the author suggest that something is good because it is natural, or bad because it is not natural (the naturalistic fallacy)?",
        options: "Yes, Sort of, No"
    },
    {
        kind: "option",
        question: "Which of the following types of sources are cited in the article?",
        options: "None, Experts, Studies, Organizations, Other"
    },
    {
        kind: "verify",
        question: "Verify whether the following types of sources are cited in the article."
    }

])

Article.create([
    {
        topic: 'health',
        subtopic: 'vaccines',
        title: 'Johns Hopkins Researcher Releases Shocking Report On Flu Vaccines',
        metadata: 'ewao.com',
        content: ' 
        ',
        expert_score: 2
    },
    {
        topic: 'climate change',
        subtopic: 'flooding',
        title: '"Floods in India, Bangladesh and Nepal kill 1,200 and leave millions homeless"',
        metadata: 'independent.co.uk',
        content: ' 
        ',
        expert_score: 3
    },
    {
        topic: 'health',
        subtopic: 'nutrition',
        title: "Coconut oil isn't healthy. It's never been healthy.",
        metadata: 'usatoday.com',
        content: ' 
        ',
        expert_score: 3
    },
    {
        topic: 'health',
        subtopic: '',
        title: 'How Your Finger Shape Determines Your Personality (And Your Health Risks)',
        metadata: 'mysticalraven.com',
        content: ' 
        ',
        expert_score: 1
    },
    {
        topic: 'health',
        subtopic: 'vaccines',
        title: 'FDA Announced That Vaccines Are Causing Autism!',
        metadata: 'inshapetoday.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: '',
        title: "Monsanto Is Scrambling To Bury This Breaking Story - Don't Let This Go Unshared!",
        metadata: 'foodbabe.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: '"CONFIRMED: E-CIGARETTES CAUSE A HORRIBLE INCURABLE DISEASE CALLED äó_""POPCORN LUNGäó_"". WORSE THAN LUNG CANCER!"',
        metadata: 'nowcheckthis.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'climate change',
        subtopic: 'polar ice',
        title: '"There are diseases hidden in ice, and they are waking up"',
        metadata: 'bbc.com',
        content: ' 
        ',
        expert_score: 3
        },
        {
        topic: 'health',
        subtopic: 'kids/moms',
        title: "Mom's warning is spreading like wildfire - scented candles are harmful to your baby's health",
        metadata: 'newsner.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'Resorts in Mexico suspected of drugging tourists',
        metadata: 'wfaa.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: 'Hand-Foot-And-Mouth Disease On The Rise: Experts Beg Parents To Know The Signs',
        metadata: 'littlethings.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: 'vaccines',
        title: "Lead Developer of HPV Vaccines Comes Clean, Warns Parents & Young Girls It's All A Giant Deadly Scam",
        metadata: 'alternativenewsnetwork.net',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: 'conspiracy',
        title: 'MISSION IMPOSSIBLE: Official story of Las Vegas shooting unravels; physical impossibility of lone gunman senior citizen makes narrative ludicrous',
        metadata: 'naturalnews.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: 'nutrition',
        title: 'Health Experts Are Warning People To Stop Eating Tilapia',
        metadata: 'androidmagazines.info',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'Stop holding your farts in. Here are 7 unexpectedhealth benefits of passing gas',
        metadata: 'shareably.net',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'climate change',
        subtopic: 'energy',
        title: 'Tesla made more money last quarter than the entire US oil industry made last year',
        metadata: 'electrek.co',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: 'nutrition',
        title: '"Drinking more coffee can lead to a longer life, new studies say"',
        metadata: 'cnn.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: '',
        title: "Putting Kids To Bed Early Improves Mom's Health",
        metadata: 'simplemost.com',
        content: ' 
        ',
        expert_score: 3
        },
        {
        topic: '"climate change, health"',
        subtopic: 'agriculture',
        title: 'Substituting Beans for Beef Would Help the U.S. Meet Climate Goals',
        metadata: 'theatlantic.com',
        content: ' 
        ',
        expert_score: 3.5
        },
        {
        topic: 'health',
        subtopic: 'nutrition',
        title: 'WITH ONLY 2 CUPS A DAY FOR 1 WEEK YOUR STOMACH WILL BE FLATTER! - Public HealthABC',
        metadata: 'publichealthabc.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: '',
        title: '9 sleeping positions to improve your health and life',
        metadata: 'ntd.tv',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'climate change',
        subtopic: 'flooding',
        title: "Hurricane Harvey: Houston's flooding made worse by unchecked urban development and wetland destruction",
        metadata: 'qz.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'Malignant narcisissm: Donald Trump displays classic traits of mental illness, claim psychologists',
        metadata: 'independent.co.uk',
        content: ' 
        ',
        expert_score: 3.5
        },
        {
        topic: 'health',
        subtopic: 'vaccines',
        title: 'Vaccinated vs. Unvaccinated: Mawson Homeschooled Study Reveals Who is Sicker',
        metadata: 'cmsri.org',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'Dancing can reverse the signs of aging in the brain',
        metadata: 'medicalxpress.com',
        content: ' 
        ',
        expert_score: 5
        },
        {
        topic: 'health',
        subtopic: 'nutrition',
        title: '"PLS SHARE: DO NOT EAT THIS FISH, IT IS VERY DANGEROUS FOR YOUR HEALTH!"',
        metadata: 'nationspressph.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: "Preventing Alzheimer's Disease, Dementia & Cognitive Decline With Diet",
        metadata: 'dailyhealthpost.com',
        content: ' 
        ',
        expert_score: 3
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'Six Pharmaceutical Drugs That Immediately Destroy Your Health',
        metadata: 'ewao.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: 'political',
        title: "Under the GOP's health plan, sexual assault could be considered a pre-existing condition",
        metadata: 'mic.com',
        content: ' 
        ',
        expert_score: 3
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: 'World Renowned Heart Surgeon Speaks Out On What Really Causes Heart Disease',
        metadata: 'dailyoccupation.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: '',
        title: 'The Best Exercise for Aging Muscles',
        metadata: 'nytimes.com',
        content: ' 
        ',
        expert_score: 5
        },
        {
        topic: 'climate change',
        subtopic: 'polar ice',
        title: "Arctic stronghold of world's seeds flooded after permafrost melts",
        metadata: 'theguardian.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: 'kids/moms',
        title: 'Birth order: First-borns get intellectual advantage',
        metadata: 'today.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'climate change',
        subtopic: 'polar ice',
        title: "DELINGPOLE: Global Warming Study Cancelled Because of 'Unprecedented' Ice",
        metadata: 'breitbart.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: 'The boy with very rare "aging disease", Sam Berns dies at 17 - he inspired millions!',
        metadata: 'ntd.tv',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: '',
        title: '"So Coconut Oil Is Actually Really, Really Bad For You"',
        metadata: 'iflscience.com',
        content: '
        You’d be hard pressed to find someone who doesn’t like coconuts. They are furry spheres of deliciousness, after all. Coconut water though is pointless – it doesn’t have any clear health benefits and it’s just a saltier version of normal water.<br><br>
        Then there’s coconut oil. It’s the latest cooking fad, and people all over the Web are claiming that it’s much healthier than any other oil out there. Well, sorry to burst your bubble, coco-nutcases, but according to the American Heart Association (AHA), it is just as unhealthy as butter and beef dripping.<br><br>
        According to a key advisory notice published in the journal <a href="http://circ.ahajournals.org/content/early/2017/06/15/CIR.0000000000000510">Circulation</a> – one which looks at all kinds of fats and their links to cardiovascular disease – coconut oil is packed with saturated fats. In fact, 82 percent of coconut oil is comprised of saturated fats, far more than in regular butter (63), olive oil (14), peanut oil (17), and sunflower oil (10).<br><br>
        Saturated fat, unlike others, can raise the amount of bad cholesterol in your bloodstream, which increases your risk of contracting heart disease in the future. It can be found in butter and lard, cakes, biscuits, fatty meats, cheese, and cream, among <a href="http://www.nhs.uk/Livewell/Goodfood/Pages/Eat-less-saturated-fat.aspx">other things</a> – including coconut oil.<br><br>
        “A recent survey reported that 72 percent of the American public rated coconut oil as a ‘healthy food’ compared with 37 percent of nutritionists,” the AHA’s review notes. “This disconnect between lay and expert opinion can be attributed to the marketing of coconut oil in the popular press.”<br><br>
        A meta-analysis of a suite of experiments have conclusively shown that butter and coconut oil, in terms of raising the amount of bad cholesterol in your body, are just as bad as each other.<br><br>
        “Because coconut oil increases [bad] cholesterol, a cause of cardiovascular disease, and has no known offsetting favorable effects, we advise against the use of coconut oil,” the AHA conclude. In essence, there is nothing to gain and everything to lose by using coconut oil in cooking.<br><br>
        <img src="http://cdn.iflscience.com/images/738f65e6-44a8-581c-8b49-9f5ed793ce52/content-1497629597-shutterstock-608546279.jpg" alt="">
        If you already have high bad cholesterol levels, then coconut oil is potentially quite dangerous to consume or use in acts of culinary creations. Swapping it out for olive oil, according to the AHA, will reduce your cholesterol levels as much as cutting-edge, cholesterol-lowering drugs.<br><br>
        So next time you see anyone claiming that coconut oil is nothing but good for you – or that it’s “pro-health and anti-everything bad!” – you can confidently tell them that they’re <a href="https://www.davidwolfe.com/2-tablespoons-coconut-oil-health/">spouting bullshit</a>.<br><br>
        It’s important to remember though that a little bit of fat is definitely good for you, as fatty acids are essential for proper absorption of vitamins. Unsaturated fats are generally thought to be quite good for you in this regard; you can find them in avocados, fish oil, nuts, and seeds.<br><br>
        [H/T: <a href="http://www.bbc.co.uk/news/health-40300145">BBC News</a>]<br><br>
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: '"Surgeon General Vivek Murthy: Addiction Is A Chronic Brain Disease, Not A Moral Failing"',
        metadata: 'huffingtonpost.com',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'health',
        subtopic: 'disease',
        title: 'Stop Calling Your Drug Addiction a Disease',
        metadata: 'awarenessact.com',
        content: ' 
        ',
        expert_score: 1
        },
        {
        topic: 'health',
        subtopic: 'conspiracy',
        title: "Five things that just don't add up about the Las Vegas mass shooting",
        metadata: 'naturalnews.com',
        content: ' 
        ',
        expert_score: 2
        },
        {
        topic: 'health',
        subtopic: 'kids/moms',
        title: "Dirt Is Good': New Book Explores Why Kids Should Be Exposed To Germs : Shots",
        metadata: 'npr.org',
        content: ' 
        ',
        expert_score: 4
        },
        {
        topic: 'climate change',
        subtopic: 'polar ice',
        title: 'An Iceberg the Size of Delaware Just Broke Away From Antarctica',
        metadata: 'nytimes.com',
        content: ' 
        ',
        expert_score: 5
        },
        {
        topic: 'climate change',
        subtopic: 'flooding',
        title: '"Heavy Monsoon Causing Extreme Flooding In South Asia Has Killed 1,200 People So Far"',
        metadata: 'iflscience.com',
        content: ' 
        ',
        expert_score: 3
        },
        {
        topic: 'climate change',
        subtopic: 'polar ice',
        title: "Arctic's Winter Sea Ice Drops to Its Lowest Recorded Level",
        metadata: 'nytimes.com',
        content: ' 
        ',
        expert_score: 4.5
        }
  
]);

Administrator.create(
    email: "admin@admin.com", 
    password: "password", 
    first_name: "Admin", 
    last_name: "User"
);

