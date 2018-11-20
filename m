Subject: Re: [Xenomai] [PATCH] build: Modernize device installation
References: <fd7363b0-ea79-3f59-08ea-b6617e1d5422@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8b4db99d-eb2c-feeb-651f-b88947743023@xenomai.org>
Date: Tue, 20 Nov 2018 16:44:01 +0100
MIME-Version: 1.0
In-Reply-To: <fd7363b0-ea79-3f59-08ea-b6617e1d5422@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/10/18 5:23 PM, Jan Kiszka wrote:
> Drop the obsoleted mknod calls - all modern systems use devtmpfs, and
> that creates the rtp nodes for us.
> 
> Furthermore, switch the remaining installation of udev rules to proper
> automake, using sysconfdir, INSTALL_DATA etc., dropping sudo from those
> steps (installation into privileged folders implies "sudo make install"
> or running as root in the first place).
> 
> Finally, only differentiate between pre-existing udev.rules and default
> installation into rules.d.
> 
> This removes the need for the install-user target - drop it.
> 

It looks like this one broke buildroot, which expects install-user. A
compat one-liner like below may help in preventing a regression:

diff --git a/Makefile.am b/Makefile.am
index ef78bee89..20610ef2b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,4 +49,6 @@ endif

 install-exec-local: udev-rules

+install-user: udev-rules
+
 .PHONY: FORCE

-- 
Philippe.

