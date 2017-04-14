From: Romain Naour <romain.naour@gmail.com>
Message-ID: <946ea421-b654-bd7d-62ab-6131ae80dc7d@gmail.com>
Date: Fri, 14 Apr 2017 15:48:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] obstack support with uClibc-ng >= 1.0.21
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Waldemar Brodkorb <wbx@openadk.org>, Pawel Sikora <sikor6@gmail.com>

Hi all,

Xenomai 3 doesn't build with recent uClibc-ng (since 1.0.21 release) since the
obstack support has been removed [1].

I proposed a patch [2] disabling this feature unconditionally but I don't really
understand how obstack support work with Xenomai and why it's required.

Do we need to add a requirement on Glibc system as suggested in [3] ?

Best regards,
Romain

[1]
https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/commit/?id=0bd6bfb2b643ea2b4b1440dfd917ba752f0c0d15
[2] http://patchwork.ozlabs.org/patch/745792/
[3] http://lists.busybox.net/pipermail/buildroot/2017-April/189244.html

