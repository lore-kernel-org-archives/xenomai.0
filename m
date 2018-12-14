From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: RTnet tests in smokey
Message-ID: <9f8fd2ac-368b-8ce9-4982-108e923fad23@siemens.com>
Date: Fri, 14 Dec 2018 13:24:15 +0100
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>

Hi all,

while debugging that list corruption in Rtnet I noticed that the related
smokey tests are in a rather improvable state. First of all, they are
never working automatically unless the rtnet core is built into the
kernel. When it is just a model, the corectl check will always fail
because the core feature is not present. That can be fixed like this:

diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
index ea3daceca5..86ebf988ff 100644
--- a/testsuite/smokey/net_common/setup.c
+++ b/testsuite/smokey/net_common/setup.c
@@ -352,6 +352,10 @@ int smokey_net_setup(const char *driver, const char *intf, int tested_config,
 	struct sockaddr_in *in_peer = vpeer;
 	struct sockaddr *peer = vpeer;
 
+	err = smokey_net_modprobe("rtnet");
+	if (err < 0)
+		return err;
+
 	err = cobalt_corectl(_CC_COBALT_GET_NET_CONFIG,
 			&net_config, sizeof(net_config));
 	if (err == -EINVAL)

But when you built more of the core into the kernel, the cleanup of the tests will start to fail.

I was considering to add the above change as patch, but then we will always fail on net_udp test unless the user also had some physical link set up. That is at least my impression because the test reports

> RTnet UDP test failed, all packets lost (is smokey_net_server running ?)

while even running "smokey_net_server rtlo" does not work:

> smokey_net_server options [ <interface> ]:
> 
> Runs server for smokey network tests, on interface named <interface>
> (rtlo if unspecified)
   ^^^^^^^^^^^^^^^^^^^

> 
> Available options:
> -f | --file <file>              Answers clients from file named <file>
>         (uses standard input if unspecified)
>         Where every line contains a mac address and an IP address
>    0"000.007| WARNING: [main] Xenomai compiled with partial debug enabled,
>                               high latencies expected [--enable-debug=partial]
> 
> Running smokey_net_server on rtlo makes no sense
                               ^^^^^^^^^^^^^^^^^^^

As we now have a fix for the bug this test revealed but digging deeper
into it and making it a working default test is likely much more effort,
I'm going to tag v3.0.8 after this fix settled and is merged over. But
the above should be addressed eventually.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

