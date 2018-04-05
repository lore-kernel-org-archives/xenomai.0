From: Philippe Gerum <rpm@xenomai.org>
References: <DB6PR0701MB2456EF1925C87F170E90540EB5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <7528e4df-ac06-8893-bf77-7cbf9e91eeef@xenomai.org>
 <DB6PR0701MB245618054AEE22508685BDE4B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Message-ID: <baa70a7e-806e-197e-7ee5-0d3489c65ff9@xenomai.org>
Date: Thu, 5 Apr 2018 15:09:58 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB245618054AEE22508685BDE4B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  xeno-config --no-mode-check still has -lmodechk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/05/2018 01:15 PM, Giulio Moro wrote:
> so would it not be up to the external libs to specify in their docs that they should be linked with -lmodechk?

You likely mean mentioning such dependency in their LDFLAGS as DSOs when
linked, which is right.

Over time, I received several reports from users of 3rd party libs which
could not assume that unfortunately. So the question boils down to:
should we break those builds to remove a generally useless dependency on
libmodechk, or should we keep this dependency to please those users and
maintain backward compat.

Another question this raises is about calling __real_* symbols directly
from the application code - which would be ok as a way to bypass the
assertion checking in this case (likewise the other way around,
referring to __wrap* calls). Not depending on libmodechk would
invalidate such usage, ending up in undefined references.

Open question AFAIC.

-- 
Philippe.

