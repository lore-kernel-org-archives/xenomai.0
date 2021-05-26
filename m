From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: Can we port latmon from zephyr to xenomai 3.2 for measuring gpio
 latency.
Date: Wed, 26 May 2021 03:59:21 +0000
Message-ID: <BN9PR11MB522741D310EA498FDA56B742F2249@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe

I have tried different ways and different X86 boards to co-work with FRDM K=
64F to get correct GPIO latency
for latmus test but failed because of voltage mismatch( 1.8V <-> 3.3V) or b=
ad signal  of gpio connection between X86 boards=20
and FRDM K64F triggering lots of invalid gpio interrupts after run.

Can we port latmon from zephyr to xenomai so that we can set up latmus and =
latmon on same type of board
which both run xenomai to measure gpio latency to avoid voltage mismatch or=
 bad signal caused by platform=20
difference?  It would also provide more options for user to setup latmon to=
 measure gpio latency.  How do you think?

Regards

Hongzhan Chen


