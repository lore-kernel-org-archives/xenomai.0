From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu,  7 Dec 2017 21:50:20 -0500
Message-Id: <1512701420-22852-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH] Add How To Contribute Guide
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 How_To_Contribute.adoc | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 How_To_Contribute.adoc

diff --git a/How_To_Contribute.adoc b/How_To_Contribute.adoc
new file mode 100644
index 0000000..60c366f
--- /dev/null
+++ b/How_To_Contribute.adoc
@@ -0,0 +1,57 @@
+How To Contribute
+=================
+
+If you are interested in contributing to Xenomai here are some helpful hints on 
+how to get started. Start small, then progress as you get your feet wet.  There
+is no such thing as a minor contribution, there is no shame in making mistakes. 
+A contributor who submits a perfectible one-liner surely advances the project 
+further than any smart lurker.
+
+Things you will need:
+    - Git
+    - GCC for your platform
+    - Xenomai source code
+    - Linux tree patched with Ipipe
+    - Autotools
+    - Access to the Xenomai mailing list (xenomai@xenomai.org)
+
+Getting Set up:
+--------------
+Before starting to contribute you should have read the following documents:
+    link:start-here[Getting Started]
+    link:getting-the-xenomai-code[Getting The Code]
+    link:installing-xenomai-3-x[Installing Xenomai]
+    link:building-applications-with-xenomai-3-x[Building Applications]
+    link:running-applications-with-xenomai-3-x[Running Applications]
+    link:getting-help[Getting Help]
+    
+Workflow
+--------
+The above mentioned documents will guide you through acquiring the source code,
+getting the development environment set up, and building Xenomai.  If you are 
+having issues getting your development environment setup or built, please review 
+the documents or consult the Xenomai mailing list.
+
+As a guideline for what branch to work on, the next branch is for new core features, 
+new CPU architecture ports or large scale changes. Only bug fixes and possibly new drivers should be pushed to stable-* branches. Any change that would prevent 
+applications based on earlier releases from the same branch from running on later ones 
+should not go into stable-* branches.  For example, an application built for the 3.0.2 release must build with no modifications on 3.0.6.
+
+Generally speaking, the kernel part of Xenomai (aka Cobalt core) aims at following the standard kernel coding style.
+
+After you make your changes, one thing to keep in mind is that when you 
+submit your patches to the the mailing list each patch should address exactly one 
+issue.  You may want to make one commit for every patch you wish to generate.  This may 
+be a good workflow if you are addressing more than one issue during development. 
+
+When you are done development and testing you are ready to generate patches.  
+Use git format-patch to create a patch (or patch set) that you can submit for review.  
+
+Once you have generated your patch (or patches) you need to send them off to the 
+mailing list for review. This can be done using git send-email.  This may be 
+slightly tricky to set up. I suggest googling for the best way to set this up in 
+your gitconfig file that best suits your email provider and authentication method. 
+Once it is configured you can submit your patch to the mailing list.
+
+
+
-- 
2.7.4


