From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] drivers/net: reformat using kernel coding style
Message-ID: <916874df-8fe5-30b5-0958-fa84d6261f65@xenomai.org>
Date: Wed, 20 Mar 2019 17:25:08 +0100
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
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


As discussed earlier on this list [1], this patch reformats the RTnet
stack according to the kernel coding style. Due to its size, I'm not
going to paste it inline; please find it at [2].

Note: the following series introducing VLAN and multicast support is
based on this patch.

[1] https://www.xenomai.org/pipermail/xenomai/2019-February/040327.html
[2]
https://lab.xenomai.org/xenomai-rpm.git/commit/?h=for-upstream/next&id=f58f8e176a366182a182362b9af0ffe41ca81d86

-- 
Philippe.

