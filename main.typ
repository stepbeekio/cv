// Typst port of main.tex + simplecv.sty — single-file CV.
// Theme color mirrors `\def\theme{black}` in main.tex — swap to recolor.
#let theme-color = black
#let color-text = rgb(26, 26, 26) // \definecolor{color-text}{gray}{0.10}
#let color-detail = rgb(102, 102, 102) // \definecolor{color-detail}{gray}{0.40}

// Shorthand link helpers (\github, \email, \website, \linkedin)
#let email(addr) = link("mailto:" + addr)[#addr]
#let github(user) = link("https://github.com/" + user + "/")[github.com/#user]
#let linkedin(user) = link("https://www.linkedin.com/in/" + user + "/")[#user]
#let website(url) = link("https://" + url + "/")[#url]

// \headinginline: name + subtitle on the left, contact block flush-right
#let heading-inline(name, subtitle, contact) = {
  grid(
    columns: (62%, 1fr),
    align: (left + bottom, right + bottom),
    [
      #text(size: 26pt, fill: theme-color)[#name] \
      #text(size: 13pt)[#subtitle]
    ],
    contact,
  )
  v(1.1em)
}

// \entrybig: title/location row, then role/date row (smaller), then optional body
#let entry-big(title, location, role, date, body: none) = block(below: 0.85em)[
  #grid(
    columns: (1fr, auto),
    [#strong(title)], [#location],
  )
  #v(-0.35em)
  #grid(
    columns: (1fr, auto),
    text(size: 9.5pt)[#role], text(size: 9.5pt)[#date],
  )
  #if body != none {
    v(0.3em)
    body
  }
]

// Wraps the document body with page/text/heading styling (apply via `#show: simplecv`)
#let simplecv(body) = {
  set page(paper: "us-letter", margin: 1in)
  set text(font: "New Computer Modern", size: 10.5pt, fill: color-text)
  set par(justify: false, leading: 0.62em)
  set list(indent: 1em, spacing: 0.55em, marker: [•])

  show heading.where(level: 1): it => block(above: 1.1em, below: 0.6em)[
    #text(size: 15pt, fill: theme-color)[#smallcaps(it.body)]
    #v(-0.5em)
    #line(length: 100%, stroke: 0.6pt + theme-color)
  ]

  body
}

#show: simplecv

#heading-inline(
  "Stephen van Beek",
  "Principal Engineer",
  align(right)[
    Email: #email("stephen@happyvalley.io") \
    LinkedIn: #linkedin("stepbeekio") \
    GitHub: #github("stepbeekio") #github("HappyValleyIO") \
  ],
)

= Experience

#entry-big(
  [*Santander Auto Software*], [Remote],
  [SDE3], [October 2023 -- Present],
  body: [
    - Established and led the development of core financial infrastructure. I designed and implemented comprehensive accounts receivable and debt collection systems, driving 10-15% of total revenue through improved collection processes. This allowed the business to reevaluate operational risk and allocate 5x more capital for expansion.
    - Launched and managed a strategic initiative to create a provisions and impairments credit risk system around IFRS 9, meeting critical European Banking Authority (EBA) requirements. This required a great deal of surprisingly complex domain modelling, and removed regulatory barriers to capital allocation, enabling business expansion.
    - Designed and implemented a global simulations system that streamlines testing of time-dependent processes, enabling teams to efficiently validate complex financial scenarios. This tool allows developers and domain experts to observe and verify multi-year workflows in a compressed timeframe (three years in under 20 minutes), unlocking true continuous deployment by eliminating manual QA in dev.
    - Founded and actively led the organization's technical steering group, driving the evolution from our initial rapid-deployment architecture to robust, scalable design practices. As a principal contributor and reviewer, I guide engineering teams across the entire stack in implementing systems to the standard required of a core banking system.
  ],
)

#entry-big(
  [*Happy Valley IO*], [Remote],
  [Co-founder & Principal Engineer], [August 2017 -- October 2023],
  body: [
    While primarily a software development role, I've also served as managing director responsible for negotiating contracts, pushing sales and directing the technical learning in the company. Projects include:

    - Principal Engineer for #link("https://www.alfransi.com.sa/english/home")[Banque Saudi Fransi]'s neo-banking subsidiary. The bank had acquired a consultancy team and used Happy Valley IO for a year to correct complex technical blockers caused by a previous consultancy while mentoring the new perm team. In this time, I:
      - discovered that a hand-rolled auth mechanism allowed JWT's from a different issuer to POST transaction requests between other accounts. I paired with various members of the team while reworking the system to use Spring Security to ensure that the knowledge of how the authN/authz of the system remained within the team.
      - resolved the architectural issues blocking launch. While ostensibly motivated by DDD, the system was divided the microservices around entities rather than aggregates leading to inconsistent state (for instance, a credit transaction without a corresponding debit). I re-architected the system around transactional integrity and the organizational structure to fewer, fatter services that could be tested more easily and leverage database transactions to ensure correctness.
      - introduced end-to-end testing that allowed automated integration tests using ISO-8583 messages to be written by the dev teams for the first time. This revealed many bugs that would have resulted in inappropriate card declines or even missing funds in production. Until that point, all testing around card transactions had been manual or relied heavily on mocks.
      - at the request of the COO, I joined the infrastructure team to help resolve several issues with the Kubernetes cluster -- the most pressing being a 5% request failure rate and poor performance. After introducing some stress testing scripts with Vegeta, we discovered that the system would crash completely at 5 req/s. Through a small code change, and coaching the infrastructure team in how to run a JVM application in production I increased throughput to 100 req/s with max latency of 300ms. During this exercise, we cut the hardware costs of the cluster by 50%.
      - to close out my time with the client, I built an on-call process with primary and secondary rotations, as well as opinionated monitoring infrastructure to ensure a smoother introduction to support for the team. In six months, the team transitioned from never having supported a production system to debugging the first friends & family production deployment of the system without support.
    - built and launched Zeevo, a graph based content-creation platform with a Web3 integration to mint NFTs. After an initial prototype built in 2 days, the client asked to build a high-fidelity MVP. I used React Flow to build the graph-editor tool to construct sequences with conditional sequels.
    - #underline[#link("http://www.bigupapp.com")[BigUp]] is a social media app focused on positive affirmation for teenagers that's recently launched in the UK. In under four months, I have led development of the entire technical stack for the app from the React Native app on iOS and android, through to the infrastructure-as-code that underpins the cloud-hosted spring boot & kotlin back-end. To enable rapid development, we've employed a devops-driven approach with multiple daily releases, high automated test coverage, and aggressive scope-hammering.

      While building BigUp I've contributed fixes to the #underline[#link("https://github.com/mrsked/mrsk")[MRSK]] project by 37signals that have enabled us to use IaaS instead of PaaS for our infrastructure, making the low margins of B2C social media viable.
  ],
)

#entry-big(
  [*Amazon.com*], [Edinburgh, UK],
  [SDE on the Dynamic Merchandising Team], [October 2015 -- August 2017],
  body: [
    Led development of the system that rendered all recommendations widgets on the retail website. The service was built in akka with scala and a single request would fan out to tens or hundreds of requests to other services. I individually built the actor graph that backed the monadic attribute fetching API and owned all performance matters for the team. Through stress testing and CPU profiling, I improved performance to the point where a single instance of the service could process 20,000 TPS with p99 latency of 250ms.

    As a part of this work, traversed many services belonging to other teams to fix the litany of bugs that blocked the publicly promised launch of Amazon Fresh in Germany and Japan and the open of the first in-person Fresh store in the USA.
  ],
)

#entry-big(
  [*JPMorgan Chase*], [Glasgow, UK],
  [Software Developer on the Pyramid Position Service], [June 2014 -- October 2015],
  body: [
    A distributed, Agile team across Glasgow and London with clients globally, the main function of the Pyramid Position Service is to serve up enriched position data for the Investment Bank's equities tech. My role involved full stack development - from web-based latency tracking and testing tools, to back-end performance and data quality work. We used Chronicle queues for IPC and spent a week working directly with Peter Lawrey on performance tuning the system with Chronicle.

    I spend the vast majority of this role working on back-end java, with the high point being a distributed data server with a 99th latency percentile of 4ms, fanning out around 150,000 msg/sec (message size 512 bytes) to multiple clients over the network using a combination of RxJava and JeroMQ.
  ],
)

= Education

#entry-big(
  [*University of Glasgow*], [Glasgow, UK],
  [BSc (Hons) in Mathematics, Upper Second], [Sep 2009 -- June 2013],
)

= Everything else

I regularly attend the gym and am a 4th Dan in shotokan karate -- traveling abroad several times a year to train.
I play the guitar -- though not as well as I'd like -- and am an avid reader.
I'm currently re-reading the Realm of the Elderlings by Robin Hobb before I inevitably re-read the Wheel of Time by Robert Jordan.
