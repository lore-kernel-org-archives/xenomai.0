From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: =?Windows-1252?Q?Re:_=91SCHED=5FNORMAL=92_not_provided_by_Xenomai_headers?=
Date: Sat, 12 Jan 2019 20:29:02 +0000
Message-ID: <AM0PR07MB5572514AFAC291FB128654BBB5860@AM0PR07MB5572.eurprd07.prod.outlook.com>
References: <AM0PR07MB5572F0A0E8B2B7C0DE7D5C87B5860@AM0PR07MB5572.eurprd07.prod.outlook.com>
In-Reply-To: <AM0PR07MB5572F0A0E8B2B7C0DE7D5C87B5860@AM0PR07MB5572.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Also, it may be worth pointing out in the docs that SCHED_SPORADIC, SCHED_T=
P,  SCHED_QUOTA need kernel support ( the docs already mention something ab=
out kernel support for  SCHED_WEAK).

Giulio
________________________________________
From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Giulio Moro via Xe=
nomai <xenomai@xenomai.org>
Sent: 12 January 2019 20:08
To: Xenomai@xenomai.org
Subject: =91SCHED_NORMAL=92 not provided by Xenomai headers

The docs for sched_setscheduler_ex() [1] and pthread_setscheparam_ex()[2]  =
claim that among the valid values for policy there is  "SCHED_NORMAL"

however, SCHED_NORMAL is not provided by any of the Xenomai headers, so you=
 get a compile-time error.

[1] https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt=
__api__scheduler.html#ga796071f20fd35a5e05972157745728af
[2] https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt=
__api__sched.html#ga405020019f5df8c7e74d30fd457384ed

