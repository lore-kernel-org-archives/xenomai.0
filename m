MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 6 Dec 2017 00:00:29 -0500
Message-ID: <CALLqZ8ScsrUwM2H5WvoY_6iH5r42fx1AKkT807iri1KS=RV2Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Contributing Doc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
   I'm putting together a doc on how to contribute.  I've pasted it
below, if anyone has some time to review and let me know what I've
missed that would be great.
  I wasn't sure if all development should take place against the next
branch or not.  I'm also not sure if I linked the documents correctly
or not in the getting setup section.
  Once it's ready should this be sent to the mailing list as a patch
against xenomai-kbase repo?

Thanks

Greg



How To Contribute
=================

If you are interested in contributing to Xenomai here are some helpful hints on
how to get started.

Things you will need:
    - Git
    - GCC for your platform
    - Xenomai source code
    - Linux tree patched with Ipipe
    - Access to the Xenomai mailing list (xenomai@xenomai.org)

Getting Setup:
--------------
Before starting to contribute you should have read the following documents:
    -link:Start_Here.adoc[]
    -link:Getting_Xenomai.adoc[]
    -link:Installing_Xenomai_3.x.adoc[]

Workflow
--------
The above mentioned documents will guide you through acquiring the
source code, getting the development environment set up, and building
Xenomai.  If you are having issues getting your development
environment setup or built please review the documents or consult the
Xenomai mailing list.

To contribute to Xenomai, switch to the branch you'd like to make your
changes on (next branch?).  After you make your changes, one thing to
keep in mind is that when you submit your patches to the the mailing
list each patch should address exactly one issue.  You may want to
make one commit for every patch you wish to generate.  This may
be a good workflow if you are addressing more than one issue during development.

Once you are done development and testing you are ready to generate
patches.  Use git format-patch to create a patch (or patch set) that
you can submit for review.

Once we have generated our patch (or patches) we need to send them off
the the mailing list for review. This can be done using git
send-email.  This may be slightly tricky to set up, I suggest googling
for the best way to set this up in your gitconfig file that best suits
your email provider and authentication method. Once it is configured
you can submit your patch to the mailing list.

