HYPERLEDGER FABRIC v1.0
=======================

<<<<<<< HEAD
Hyperledger Fabric is a platform that enables the delivery of a secure,
=======
Hyperledger fabric is a platform that enables the delivery of a secure,
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst
robust, permissioned blockchain for the enterprise that incorporates a
byzantine fault tolerant consensus. We have learned much as we
progressed through the v0.6-preview release. In particular, that in
order to provide for the scalability and confidentiality needs of many
use cases, a refactoring of the architecture was needed. The
v0.6-preview release will be the final (barring any bug fixes) release
based upon the original architecture.

<<<<<<< HEAD
Hyperledger Fabric's v1.0 architecture has been designed to address two
=======
Hyperledger fabric's v1.0 architecture has been designed to address two
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst
vital enterprise-grade requirements – **security** and **scalability**.
Businesses and organizations can leverage this new architecture to
execute confidential transactions on networks with shared or common
assets – e.g. supply chain, FOREX market, healthcare, etc. The
progression to v1.0 will be incremental, with myriad windows for
community members to contribute code and start curating the fabric to
fit specific business needs.

WHERE WE ARE:
-------------

The current implementation involves every validating peer shouldering
the responsibility for the full gauntlet of network functionality. They
execute transactions, perform consensus, and maintain the shared ledger.
Not only does this configuration lay a huge computational burden on each
peer, hindering scalability, but it also constricts important facets of
privacy and confidentiality. Namely, there is no mechanism to “channel”
<<<<<<< HEAD
or “silo” confidential transactions. Every peer can see the most minute,
and at times, sensitive details and logic of every transaction. This is
untenable for many enterprise businesses, who must abide by stringent
regulatory statutes.
=======
or “silo” confidential transactions. Every peer can see the logic for
every transaction.
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst

WHERE WE'RE GOING
-----------------

<<<<<<< HEAD
| The new architecture introduces a clear functional separation of peer
  roles, and allows a transaction to pass through the network in a
  structured and modularized fashion.
| The peers are diverged into two distinct roles – Endorser & Committer.
  As an endorser, the peer will simulate the transaction and ensure that
  the outcome is both deterministic and stable. As a committer, the peer
  will validate the integrity of a transaction and then append to the
  ledger. Now confidential transactions can be sent to specific
  endorsers and their correlating committers, without the broader
  network being made cognizant of the transaction. Additionally,
  policies can be set to determine what levels of “endorsement” and
  “validation” are acceptable for a specific class of transactions.
| A failure to meet these thresholds would simply result in a
  transaction being withdrawn or labeled as "invalid", rather than
  imploding or stagnating the entire network.
| This new model also introduces the possibility for more elaborate
  networks, such as a foreign exchange market. For example, trade
  settlement might be contingent upon a mandatory "endorsement" from a
  trusted third party (e.g. a clearing house).

| The consensus or "ordering" process (i.e. algorithmic computation) is
  entirely abstracted from the peer. This modularity not only provides a
  powerful security layer – the ordering nodes are agnostic to the
  transaction logic – but it also generates a framework where ordering
  can become a pluggable implementation and scalability can truly occur.
| There is no longer a parallel relationship between the number of peers
  in a network and the number of orderers. Now networks can grow
  dynamically (i.e. add endorsers and committers) without having to add
  corresponding orderers, all the while existing in a modular
  infrastructure designed to support high transaction throughput.
  Moreover, networks now have the capability to completely liberate
  themselves from the computational and legal burden of ordering by
  tapping into a pre-existing or third party-hosted "ordering service."
=======
The new architecture introduces a clear functional separation of peer
roles, and allows a transaction to pass through the network in a
structured and modularized fashion. The peers are diverged into two
distinct roles – Endorser & Committer. As an endorser, the peer will
simulate the transaction and ensure that the outcome is both
deterministic and stable. As a committer, the peer will validate the
integrity of a transaction and then append to the ledger. Now
confidential transactions can be sent to specific endorsers and their
correlating committers, without the network being made cognizant of the
transaction. Additionally, policies can be set to determine what levels
of “endorsement” and “validation” are acceptable for a specific class of
transactions. A failure to meet these thresholds would simply result in
a transaction being withdrawn, rather than imploding or stagnating the
entire network. This new model also introduces the possibility for more
elaborate networks, such as a foreign exchange market. Entities may need
to only participate as endorsers for their transactions, while leaving
consensus and commitment (i.e. settlement in this scenario) to a trusted
third party such as a clearing house.

The consensus process (i.e. algorithmic computation) is entirely
abstracted from the peer. This modularity not only provides a powerful
security layer – the consenting nodes are agnostic to the transaction
logic – but it also generates a framework where consensus can become
pluggable and scalability can truly occur. There is no longer a parallel
relationship between the number of peers in a network and the number of
consenters. Now networks can grow dynamically (i.e. add endorsers and
committers) without having to add corresponding consenters, and exist in
a modular infrastructure designed to support high transaction
throughput. Moreover, networks now have the capability to completely
liberate themselves from the computational and legal burden of consensus
by tapping into a pre-existing consensus cloud.
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst

As v1.0 manifests, we will see the foundation for interoperable
blockchain networks that have the ability to scale and transact in a
manner adherent with regulatory and industry standards. Watch how fabric
v1.0 and the Hyperledger Project are building a true blockchain for
business -

<<<<<<< HEAD
|HYPERLEDGERv1.0\_ANIMATION|
=======
`v1.0 in motion <https://www.youtube.com/watch?v=EKa5Gh9whgU>`__
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst

HOW TO CONTRIBUTE
-----------------

<<<<<<< HEAD
Use the following links to explore upcoming additions to the codebase
that will spawn the capabilities in v1.0:

-  Familiarize yourself with the `guidelines for code
   contributions <CONTRIBUTING.md>`__ to this project. **Note**: In
   order to participate in the development of the Hyperledger Fabric
   project, you will need an `LF account <Gerrit/lf-account.md>`__. This
   will give you single sign-on to JIRA and Gerrit.
-  Explore the design document for the new
   `architecture <https://github.com/hyperledger/fabric/blob/master/proposals/r1/Next-Consensus-Architecture-Proposal.md>`__
-  Explore design docs for the various `Fabric
   components <https://wiki.hyperledger.org/community/fabric-design-docs>`__
-  Explore `JIRA <https://jira.hyperledger.org/projects/FAB/issues/>`__
   for open Hyperledger Fabric issues.
-  Explore the
   `JIRA <https://jira.hyperledger.org/projects/FAB/issues/>`__ backlog
   for upcoming Hyperledger Fabric issues.
-  Explore `JIRA <https://jira.hyperledger.org/issues/?filter=10147>`__
   for Hyperledger Fabric issues tagged with "help wanted."
=======
Use the following links to explore upcoming additions to fabric's
codebase that will spawn the capabilities in v1.0:

-  Familiarize yourself with the :doc:`guidelines for code
   contributions <CONTRIBUTING>` to this project. **Note**: In
   order to participate in the development of the Hyperledger fabric
   project, you will need an :doc:`LF account <Gerrit/lf-account>` This
   will give you single sign-on to JIRA and Gerrit.
-  Explore the design document for the new
   `architecture <https://github.com/hyperledger-archives/fabric/wiki/Next-Consensus-Architecture-Proposal>`__
-  Explore `JIRA <https://jira.hyperledger.org/projects/FAB/issues/>`__
   for open Hyperledger fabric issues.
-  Explore the
   `JIRA <https://jira.hyperledger.org/projects/FAB/issues/>`__ backlog
   for upcoming Hyperledger fabric issues.
-  Explore `JIRA <https://jira.hyperledger.org/issues/?filter=10147>`__
   for Hyperledger fabric issues tagged with "help wanted."
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst
-  Explore the `source code <https://github.com/hyperledger/fabric>`__
-  Explore the
   `documentation <http://hyperledger-fabric.readthedocs.io/en/latest/>`__

.. |HYPERLEDGERv1.0\_ANIMATION| image:: http://img.youtube.com/vi/EKa5Gh9whgU/0.jpg
   :target: http://www.youtube.com/watch?v=EKa5Gh9whgU
