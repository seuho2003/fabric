<<<<<<< HEAD
*Needs Review*

Glossary
===========================

Terminology is important, so that all Fabric users and developers agree on what
we mean by each specific term. What is chaincode, for example. So we'll point you
there, whenever you want to reassure yourself. Of course, feel free to read the
entire thing in one sitting if you like, it's pretty enlightening!

.. _Anchor-Peer:

Anchor Peer
-----------

A peer node on a channel that all other peers can discover and communicate with.
Each Member_ on a channel has an anchor peer (or multiple anchor peers to prevent
single point of failure), allowing for peers belonging to different Members to
discover all existing peers on a channel.


.. _Block:

Block
-----

An ordered set of transactions that is cryptographically linked to the
preceding block(s) on a channel.

.. _Chain:

Chain
-----

The ledger's chain is a transaction log structured as hash-linked blocks of
transactions. Peers receive blocks of transactions from the ordering service, mark
the block's transactions as valid or invalid based on endorsement policies and
concurrency violations, and append the block to the hash chain on the peer's
file system.

.. _chaincode:

Chaincode
---------

Chaincode is software, running on a ledger, to encode assets and the transaction
instructions (business logic) for modifying the assets.

.. _Channel:

Channel
-------

A channel is a private blockchain overlay on a Fabric network, allowing for data
isolation and confidentiality. A channel-specific ledger is shared across the
peers in the channel, and transacting parties must be properly authenticated to
a channel in order to interact with it.  Channels are defined by a
Configuration-Block_.

.. _Commitment:

Commitment
----------

Each Peer_ on a channel validates ordered blocks of
transactions and then commits (writes/appends) the blocks to its replica of the
channel Ledger_. Peers also mark each transaction in each block
as valid or invalid.

.. _Concurrency-Control-Version-Check:

Concurrency Control Version Check
---------------------------------

Concurrency Control Version Check is a method of keeping state in sync across
peers on a channel. Peers execute transactions in parallel, and before commitment
to the ledger, peers check that the data read at execution time has not changed.
If the data read for the transaction has changed between execution time and
commitment time, then a Concurrency Control Version Check violation has
occurred, and the transaction is marked as invalid on the ledger and values
are not updated in the state database.

.. _Configuration-Block:

Configuration Block
-------------------

Contains the configuration data defining members and policies for a system
chain (ordering service) or channel. Any configuration modifications to a
channel or overall network (e.g. a member leaving or joining) will result
in a new configuration block being appended to the appropriate chain. This
block will contain the contents of the genesis block, plus the delta.

.. Consensus

Consensus
---------

A broader term overarching the entire transactional flow, which serves to generate
an agreement on the order and to confirm the correctness of the set of transactions
constituting a block.

.. _Current-State:

Current State
-------------

The current state of the ledger represents the latest values for all keys ever
included in its chain transaction log. Peers commit the latest values to ledger
current state for each valid transaction included in a processed block. Since
current state represents all latest key values known to the channel, it is
sometimes referred to as World State. Chaincode executes transaction proposals
against current state data.

.. _Dynamic-Membership:

Dynamic Membership
------------------

Fabric supports the addition/removal of members, peers, and ordering service
nodes, without compromising the operationality of the overall network. Dynamic
membership is critical when business relationships adjust and entities need to
be added/removed for various reasons.

.. _Endorsement:

Endorsement
-----------

Refers to the process where specific peer nodes execute a transaction and return
a ``YES/NO`` response to the client application that generated the transaction proposal.
Chaincode applications have corresponding endorsement policies, in which the endorsing
peers are specified.

.. _Endorsement-policy:

Endorsement policy
------------------

Defines the peer nodes on a channel that must execute transactions attached to a
specific chaincode application, and the required combination of responses (endorsements).
A policy could require that a transaction be endorsed by a minimum number of
endorsing peers, a minimum percentage of endorsing peers, or by all endorsing
peers that are assigned to a specific chaincode application. Policies can be
curated based on the application and the desired level of resilience against
misbehavior (deliberate or not) by the endorsing peers.  A distinct endorsement
policy for deploy transactions, which install new chaincode, is also required.

.. _Genesis-Block:

Genesis Block
-------------

The configuration block that initializes a blockchain network or channel, and
also serves as the first block on a chain.

.. _Gossip-Protocol:

Gossip Protocol
---------------

The gossip data dissemination protocol performs three functions:
1) manages peer discovery and channel membership;
2) disseminates ledger data across all peers on the channel;
3) syncs ledger state across all peers on the channel.
Refer to the :doc:`Gossip <gossip>` topic for more details.

.. _Initialize:

Initialize
----------

A method to initialize a chaincode application.

Install
-------

The process of placing a chaincode on a peer's file system.

Instantiate
-----------

The process of starting a chaincode container.

.. _Invoke:

Invoke
------

Used to call chaincode functions. Invocations are captured as transaction
proposals, which then pass through a modular flow of endorsement, ordering,
validation, committal. The structure of invoke is a function and an array of
arguments.

.. _Leading-Peer:

Leading Peer
------------

Each Member_ can own multiple peers on each channel that
it subscribes to. One of these peers is serves as the leading peer for the channel,
in order to communicate with the network ordering service on behalf of the
member. The ordering service "delivers" blocks to the leading peer(s) on a
channel, who then distribute them to other peers within the same member cluster.

.. _Ledger:

Ledger
------

A ledger is a channel's chain and current state data which is maintained by each
peer on the channel.

.. _Member:

Member
------

A legally separate entity that owns a unique root certificate for the network.
Network components such as peer nodes and application clients will be linked to a member.

.. _MSP:

Membership Service Provider
---------------------------

The Membership Service Provider (MSP) refers to an abstract component of the
system that provides credentials to clients, and peers for them to participate
in a Hyperledger Fabric network. Clients use these credentials to authenticate
their transactions, and peers use these credentials to authenticate transaction
processing results (endorsements). While strongly connected to the transaction
processing components of the systems, this interface aims to have membership
services components defined, in such a way that alternate implementations of
this can be smoothly plugged in without modifying the core of transaction
processing components of the system.

.. _Membership-Services:

Membership Services
-------------------

Membership Services authenticates, authorizes, and manages identities on a
permissioned blockchain network. The membership services code that runs in peers
and orderers both authenticates and authorizes blockchain operations.  It is a
PKI-based implementation of the Membership Services Provider (MSP) abstraction.

The ``fabric-ca`` component is an implementation of membership services to manage
identities. In particular, it handles the issuance and revocation of enrollment
certificates and transaction certificates.

An enrollment certificate is a long-term identity credential; a transaction
certificate is a short-term identity credential which is both anonymous and un-linkable.

.. _Ordering-Service:

Ordering Service
----------------

A defined collective of nodes that orders transactions into a block.  The ordering
service exists independent of the peer processes and orders transactions on a
first-come-first-serve basis for all channel's on the network.  The ordering service is
designed to support pluggable implementations beyond the out-of-the-box SOLO and Kafka varieties.
The ordering service is a common binding for the overall network; it contains the cryptographic
identity material tied to each Member_.

.. _Peer:

Peer
----

A network entity that maintains a ledger and runs chaincode containers in order to perform
read/write operations to the ledger.  Peers are owned and maintained by members.

.. _Policy:

Policy
------

There are policies for endorsement, validation, block committal, chaincode
management and network/channel management.

.. _Proposal:

Proposal
--------

A request for endorsement that is aimed at specific peers on a channel. Each
proposal is either an instantiate or an invoke (read/write) request.

.. _Query:

Query
-----

A query requests the value of a key(s) against the current state.

.. _SDK:

Software Development Kit (SDK)
------------------------------

The Hyperledger Fabric client SDK provides a structured environment of libraries
for developers to write and test chaincode applications. The SDK is fully
configurable and extensible through a standard interface. Components, including
cryptographic algorithms for signatures, logging frameworks and state stores,
are easily swapped in and out of the SDK. The SDK API uses protocol buffers over
gRPC for transaction processing, membership services, node traversal and event
handling applications to communicate across the fabric. The SDK comes in
multiple flavors - Node.js, Java. and Python.

.. _State-DB:

State Database
--------------

Current state data is stored in a state database for efficient reads and queries
from chaincode. These databases include levelDB and couchDB.

.. _System-Chain:

System Chain
------------

Contains a configuration block defining the network at a system level. The
system chain lives within the ordering service, and similar to a channel, has
an initial configuration containing information such as: MSP information, policies,
and configuration details.  Any change to the overall network (e.g. a new org
joining or a new ordering node being added) will result in a new configuration block
being added to the system chain.

The system chain can be thought of as the common binding for a channel or group
of channels.  For instance, a collection of financial institutions may form a
consortium (represented through the system chain), and then proceed to create
channels relative to their aligned and varying business agendas.

.. _Transaction:

Transaction
-----------

An invoke or instantiate operation.  Invokes are requests to read/write data from
the ledger.  Instantiate is a request to start a chaincode container on a peer.
=======
Roles & Personas
----------------

 *Roles*
------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Chain Member

.. raw:: html

   </td>

.. raw:: html

   <td>

Entities that do not participate in the validation process of a
blockchain network, but help to maintain the integrity of a network.
Unlike Chain transactors, chain members maintain a local copy of the
ledger.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Chain Transactor

.. raw:: html

   </td>

.. raw:: html

   <td>

Entities that have permission to create transactions and query network
data.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Chain Validator

.. raw:: html

   </td>

.. raw:: html

   <td>

Entities that own a stake of a chain network. Each chain validator has a
voice in deciding whether a transaction is valid, therefore chain
validators can interrogate all transactions sent to their chain.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Chain Auditor

.. raw:: html

   </td>

.. raw:: html

   <td>

Entities with the permission to interrogate transactions.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Participants*
-------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Solution User

.. raw:: html

   </td>

.. raw:: html

   <td>

End users are agnostic about the details of chain networks, they
typically initiate transactions on a chain network through applications
made available by solutions providers.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: None

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Solution Provider

.. raw:: html

   </td>

.. raw:: html

   <td>

Organizations that develop mobile and/or browser based applications for
end (solution) users to access chain networks. Some application owners
may also be network owners.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Transactor

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Network Proprietor

.. raw:: html

   </td>

.. raw:: html

   <td>

Proprietor(s) setup and define the purpose of a chain network. They are
the stakeholders of a network.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Transactor, Chain Validator

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Network Owner

.. raw:: html

   </td>

.. raw:: html

   <td>

Owners are stakeholders of a network that can validate transactions.
After a network is first launched, its proprietor (who then becomes an
owner) will invite business partners to co-own the network (by assigning
them validating nodes). Any new owner added to a network must be
approved by its existing owners.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Transactor, Chain Validator

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Network Member

.. raw:: html

   </td>

.. raw:: html

   <td>

Members are participants of a blockchain network that cannot validate
transactions but has the right to add users to the network.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Transactor, Chain Member

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Network Users

.. raw:: html

   </td>

.. raw:: html

   <td>

End users of a network are also solution users. Unlike network owners
and members, users do not own nodes. They transact with the network
through an entry point offered by a member or an owner node.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Transactor

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Network Auditors

.. raw:: html

   </td>

.. raw:: html

   <td>

Individuals or organizations with the permission to interrogate
transactions.

.. raw:: html

   <p>

.. raw:: html

   <p>

Roles: Chain Auditor

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>



Business Network
----------------

 *Types of Networks (Business View)*
 ------------------------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Industry Network

.. raw:: html

   </td>

.. raw:: html

   <td>

A chain network that services solutions built for a particular industry.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Regional Industry Network

.. raw:: html

   </td>

.. raw:: html

   <td>

A chain network that services applications built for a particular
industry and region.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Application Network

.. raw:: html

   </td>

.. raw:: html

   <td>

A chain network that only services a single solution.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Types of Chains (Conceptual View)*
----------------------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Main Chain

.. raw:: html

   </td>

.. raw:: html

   <td>

A business network; each main chain operates one or multiple
applications/solutions validated by the same group of organizations.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Confidential Chain

.. raw:: html

   </td>

.. raw:: html

   <td>

A special purpose chain created to run confidential business logic that
is only accessible by contract stakeholders.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 

Network Management
------------------

 *Member management*
 ------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Owner Registration

.. raw:: html

   </td>

.. raw:: html

   <td>

The process of registering and inviting new owner(s) to a blockchain
network. Approval from existing network owners is required when adding
or deleting a participant with ownership right

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Member Registration

.. raw:: html

   </td>

.. raw:: html

   <td>

The process of registering and inviting new network members to a
blockchain network.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

User Registration

.. raw:: html

   </td>

.. raw:: html

   <td>

The process of registering new users to a blockchain network. Both
members and owners can register users on their own behalf as long as
they follow the policy of their network.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 

Transactions
------------

 *Types of Transactions*
 ----------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Deployment Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

Transactions that deploy a new chaincode to a chain.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Invocation Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

Transactions that invoke a function on a chaincode.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Confidentiality of Transactions*
--------------------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Public Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

A transaction with its payload in the open. Anyone with access to a
chain network can interrogate the details of public transactions.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Confidential Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

A transaction with its payload cryptographically hidden such that no one
besides the stakeholders of a transaction can interrogate its content.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Confidential Chaincode Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

A transaction with its payload encrypted such that only validators can
decrypt them. Chaincode confidentiality is determined during deploy
time. If a chaincode is deployed as a confidential chaincode, then the
payload of all subsequent invocation transactions to that chaincode will
be encrypted.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Inter-chain Transactions*
-------------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Inter-Network Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

Transactions between two business networks (main chains).

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Inter-Chain Transaction

.. raw:: html

   </td>

.. raw:: html

   <td>

Transactions between confidential chains and main chains. Chaincodes in
a confidential chain can trigger transactions on one or multiple main
chain(s).

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 

Network Entities
----------------

 *Systems*
 --------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Application Backend

.. raw:: html

   </td>

.. raw:: html

   <td>

Purpose: Backend application service that supports associated mobile
and/or browser based applications.

.. raw:: html

   <p>

.. raw:: html

   <p>

Key Roles:

.. raw:: html

   <p>

1)  ::

        Manages end users and registers them with the membership service

    .. raw:: html

       <p>

2)  ::

        Initiates transactions requests, and sends the requests to a node

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Owned by: Solution Provider, Network Proprietor

    .. raw:: html

       </td>

    .. raw:: html

       </tr>

    .. raw:: html

       <tr>

    .. raw:: html

       <td width="20%">

    Non Validating Node (Peer)

    .. raw:: html

       </td>

    .. raw:: html

       <td>

    Purpose: Constructs transactions and forwards them to validating
    nodes. Peer nodes keep a copy of all transaction records so that
    solution providers can query them locally.

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Key Roles:

    .. raw:: html

       <p>

3)  ::

        Manages and maintains user certificates issued by the membership service<p>

4)  ::

        Constructs transactions and forwards them to validating nodes <p>

5)  ::

        Maintains a local copy of the ledger, and allows application owners to query information locally.

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Owned by: Solution Provider, Network Auditor

    .. raw:: html

       </td>

    .. raw:: html

       </tr>

    .. raw:: html

       <tr>

    .. raw:: html

       <td width="20%">

    Validating Node (Peer)

    .. raw:: html

       </td>

    .. raw:: html

       <td>

    Purpose: Creates and validates transactions, and maintains the state
    of chaincodes

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Key Roles:

    .. raw:: html

       <p>

6)  ::

        Manages and maintains user certificates issued by membership service<p>

7)  ::

        Creates transactions<p>

8)  ::

        Executes and validates transactions with other validating nodes on the network<p>

9)  ::

        Maintains a local copy of ledger<p>

10) ::

        Participates in consensus and updates ledger

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Owned by: Network Proprietor, Solution Provider (if they belong to
    the same entity)

    .. raw:: html

       </td>

    .. raw:: html

       </tr>

    .. raw:: html

       <tr>

    .. raw:: html

       <td width="20%">

    Membership Service

    .. raw:: html

       </td>

    .. raw:: html

       <td>

    Purpose: Issues and manages the identity of end users and
    organizations

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Key Roles:

    .. raw:: html

       <p>

11) ::

        Issues enrollment certificate to each end user and organization<p>

12) ::

        Issues transaction certificates associated to each end user and organization<p>

13) ::

        Issues TLS certificates for secured communication between Hyperledger fabric entities<p>

14) ::

        Issues chain specific keys

    .. raw:: html

       <p>

    .. raw:: html

       <p>

    Owned by: Third party service provider

    .. raw:: html

       </td>

    .. raw:: html

       </tr>

    .. raw:: html

       </table>

 *Membership Service Components*
------------------------------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Registration Authority

.. raw:: html

   </td>

.. raw:: html

   <td>

Assigns registration username & registration password pairs to network
participants. This username/password pair will be used to acquire
enrollment certificate from ECA.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Enrollment Certificate Authority (ECA)

.. raw:: html

   </td>

.. raw:: html

   <td>

Issues enrollment certificates (ECert) to network participants that have
already registered with a membership service. ECerts are long term
certificates used to identify individual entities participating in one
or more networks.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Transaction Certificate Authority (TCA)

.. raw:: html

   </td>

.. raw:: html

   <td>

Issues transaction certificates (TCerts) to ECert owners. An infinite
number of TCerts can be derived from each ECert. TCerts are used by
network participants to send transactions. Depending on the level of
security requirements, network participants may choose to use a new
TCert for every transaction.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

TLS-Certificate Authority (TLS-CA)

.. raw:: html

   </td>

.. raw:: html

   <td>

Issues TLS certificates to systems that transmit messages in a chain
network. TLS certificates are used to secure the communication channel
between systems.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 

Hyperledger Fabric Entities
---------------------------

 *Chaincode*
 ----------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Public Chaincode

.. raw:: html

   </td>

.. raw:: html

   <td>

Chaincodes deployed by public transactions, these chaincodes can be
invoked by any member of the network.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Confidential Chaincode

.. raw:: html

   </td>

.. raw:: html

   <td>

Chaincodes deployed by confidential transactions, these chaincodes can
only be invoked by validating members (Chain validators) of the network.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Access Controlled Chaincode

.. raw:: html

   </td>

.. raw:: html

   <td>

Chaincodes deployed by confidential transactions that also embed the
tokens of approved invokers. These invokers are also allowed to invoke
confidential chaincodes even though they are not validators.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Ledger*
-------------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Chaincode-State

.. raw:: html

   </td>

.. raw:: html

   <td>

HPL provides state support; Chaincodes access internal state storage
through state APIs. States are created and updated by transactions
calling chaincode functions with state accessing logic.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Transaction List

.. raw:: html

   </td>

.. raw:: html

   <td>

All processed transactions are kept in the ledger in their original form
(with payload encrypted for confidential transactions), so that network
participants can interrogate past transactions to which they have access
permissions.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Ledger Hash

.. raw:: html

   </td>

.. raw:: html

   <td>

A hash that captures the present snapshot of the ledger. It is a product
of all validated transactions processed by the network since the genesis
transaction.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>

 *Node*
-----------

.. raw:: html

   <table border="0">

.. raw:: html

   <col>

.. raw:: html

   <col>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

DevOps Service

.. raw:: html

   </td>

.. raw:: html

   <td>

The frontal module on a node that provides APIs for clients to interact
with their node and chain network. This module is also responsible to
construct transactions, and work with the membership service component
to receive and store all types of certificates and encryption keys in
its storage.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Node Service

.. raw:: html

   </td>

.. raw:: html

   <td>

The main module on a node that is responsible to process transactions,
deploy and execute chaincodes, maintain ledger data, and trigger the
consensus process.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   <tr>

.. raw:: html

   <td width="20%">

Consensus

.. raw:: html

   </td>

.. raw:: html

   <td>

The default consensus algorithm of Hyperledger fabric is an
implementation of PBFT.

.. raw:: html

   </td>

.. raw:: html

   </tr>

.. raw:: html

   </table>
>>>>>>> efef932... [FAB-2977] convert v0.6 .md to .rst
