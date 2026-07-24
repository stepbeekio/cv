// Single-file CV. Swap theme-color to recolor.
#let theme-color = black
#let color-text = rgb(26, 26, 26)
#let color-detail = rgb(102, 102, 102)

// Shorthand link helpers
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

// \entrybig: title/location row, then role/date row(s) (smaller), then optional body.
// Pass extra-roles for promotions at the same company, e.g.
// extra-roles: (([Senior SDE], [Jan 2022 -- Oct 2023]), ([SDE], [Aug 2020 -- Jan 2022]))
#let entry-big(title, location, role, date, extra-roles: (), body: none) = block(below: 1.4em)[
  #grid(
    columns: (1fr, auto),
    [#strong(title)], [#location],
  )
  #for (r, d) in ((role, date), ..extra-roles) [
    #v(-0.35em)
    #grid(
      columns: (1fr, auto),
      text(size: 9.5pt)[#r], text(size: 9.5pt)[#d],
    )
  ]
  #if body != none {
    v(0.05em)
    body
  }
]

// Page/text/heading styling
#set page(paper: "us-letter", margin: 1in)
#set text(font: "New Computer Modern", size: 10.5pt, fill: color-text)
#set par(justify: false, leading: 0.62em)
#set list(indent: 1em, spacing: 0.55em, marker: [•])
#show link: underline

#show heading.where(level: 1): it => block(above: 1.1em, below: 0.6em)[
  #text(size: 15pt, fill: theme-color)[#smallcaps(it.body)]
  #v(-0.5em)
  #line(length: 100%, stroke: 0.6pt + theme-color)
]

#heading-inline(
  "Stephen van Beek",
  "Principal Engineer",
  align(right)[
    Email: #email("stephen.van.beek@hey.com") \
    LinkedIn: #linkedin("stepbeekio") \
    GitHub: #github("stepbeekio") \
  ],
)

= Experience

#entry-big(
  [*Openbank Auto*], [Remote],
  [Principal Engineer], [June 2025 -- Present],
  extra-roles: (([SDE3], [October 2023 -- June 2025]),),
  body: [
    Principal Engineer supporting 30-40 engineers, with a heavy emphasis on individual output. I focus on the business's most critical technical and business issues, working closely with senior leadership.

    - Pitched, built, and grew Openbank Auto's core finance function into a team, delivering bookkeeping systems that model partial payments, overpayments, fees, interest, and reimbursements -- reducing operational risk and driving 10-15% of operational leasing revenue, which freed 5x more capital for expansion.
    - Led the initiative to build a provisions and impairments credit risk system using IFRS 9's simplified approach for trade receivables, meeting EBA requirements and clearing the regulatory blocker to business expansion.
    - Founded the technical steering group, driving the org's evolution from rapid-deployment architecture to scalable, core-banking-grade design practices. Now lead engineering teams across the stack as principal reviewer, holding systems to that standard.
  ],
)

#entry-big(
  [*Happy Valley IO*], [Remote],
  [Co-founder & Principal Engineer], [August 2017 -- October 2023],
  body: [
    While primarily a software development role, I've also served as managing director responsible for negotiating contracts, pushing sales and directing the technical learning in the company. Projects include:

    - Lead engineer for RMR, a US relocation company whose legacy suite ran on Windows Server 2000 and SQL Server 2000 with ActiveX protections disabled, and had already suffered ransomware attacks. From 2017, built new tariff software and rebuilt the suite into a modern, secure platform -- including contributing a fix upstream to HikariCP for a SQL Server driver issue -- raising availability from 94% to 99.9% and cutting the outages, rework, and manual firefighting that had been eating into the business. These efficiency gains doubled revenue per employee.
    - Built and ran Member Magic, our own membership-management SaaS for gyms and personal trainers -- handling billing, class booking, and automated notifications and collections, processing £25,000/month in customer payments.
    - Principal Engineer for #link("https://www.alfransi.com.sa/english/home")[Banque Saudi Fransi]'s neo-banking subsidiary, for a year fixing technical blockers left by a previous consultancy and mentoring the incoming permanent team. The role called for technical leadership across the full stack, starting with the architecture blocking launch: microservices split around entities rather than DDD aggregates were causing inconsistent state -- credits without matching debits -- and had left the system untestable end-to-end. I re-architected around transactional integrity into fewer, fatter services, which for the first time let me introduce end-to-end tests against real ISO-8583 messages, catching bugs that would otherwise have caused wrongful declines or lost funds in production. With that foundation in place, the remaining blockers became tractable: I traced a security hole to a hand-rolled auth mechanism that accepted JWTs from a different issuer to post transactions between accounts and closed it, and, at the COO's request, fixed a Kubernetes cluster crashing at 5 req/s, raising throughput to 100 req/s while halving hardware costs.
    - #link("http://www.bigupapp.com")[BigUp] -- led development of a social media app for teen positive affirmation across the full stack, from the React Native app (iOS/Android) through to the infrastructure-as-code underpinning a cloud-hosted Spring Boot/Kotlin back-end -- launching in the UK in under four months. Used a devops-driven approach (multiple daily releases, high automated test coverage, aggressive scope-cutting) to hit that pace.

      Contributed fixes to the #link("https://github.com/mrsked/mrsk")[MRSK] project by 37signals that let the team run on IaaS instead of PaaS, making the low margins of B2C social media viable.
  ],
)

#entry-big(
  [*Amazon.com*], [Edinburgh, UK],
  [SDE on the Dynamic Merchandising Team], [October 2015 -- August 2017],
  body: [
    Led development of the service rendering all recommendation widgets on the retail website -- built in Scala/Akka, fanning out to tens or hundreds of downstream requests per request. Built the actor graph backing its monadic attribute-fetching API and owned performance for the team; stress testing and CPU profiling took a single instance to 20,000 TPS at 250ms p99 latency.

    Fixed bugs across other teams' services blocking the publicly promised launches of Amazon Fresh in Germany and Japan and the first in-person Fresh store in the US.
  ],
)

#entry-big(
  [*JPMorgan Chase*], [Glasgow, UK],
  [Software Developer on the Pyramid Position Service], [June 2014 -- October 2015],
  body: [
    Full-stack developer on the Pyramid Position Service, serving enriched position data to the Investment Bank's global equities tech from a distributed Agile team spanning Glasgow and London. Built web-based latency tracking and testing tools, and worked on back-end performance and data quality, including a week tuning Chronicle queues directly with Peter Lawrey.

    Built a distributed data server fanning out \~150,000 msg/sec (512-byte messages) to multiple clients over the network using RxJava and JeroMQ, with a p99 latency of 4ms.
  ],
)

= Education

#entry-big(
  [*University of Glasgow*], [Glasgow, UK],
  [BSc (Hons) in Mathematics, Upper Second], [Sep 2009 -- June 2013],
)

= Everything else

I'm a 4th Dan in shotokan karate and train abroad several times a year. I play guitar and read avidly -- currently re-reading Robin Hobb's Realm of the Elderlings before the inevitable return to the Wheel of Time.
