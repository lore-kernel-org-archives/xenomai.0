References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
 <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
 <340fed26-23db-86a4-faf5-4e58c15504cd@numalliance.com>
 <20161208084239.3f0c064b@md1em3qc>
 <2af94483-4d8f-dbcf-0711-d2408d0802ef@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5657768b-0f08-85ed-00bf-c78791546d64@xenomai.org>
Date: Fri, 9 Dec 2016 17:20:42 +0100
MIME-Version: 1.0
In-Reply-To: <2af94483-4d8f-dbcf-0711-d2408d0802ef@numalliance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/09/2016 04:28 PM, Stéphane Ancelot wrote:

>>> I remember I have not had this problem with previous kernel releases
>>> (3.16.x) .
> I tried kernel 3.16.7,3.18.20 and 4.1.18.

So there is eventually an issue with your app on a 3.16 kernel, unlike
the initial post suggested?

> this happens in 32 bit or 64 bit, both SMP kernel
> 
> I made 2 traces to open with kernelshark (please advice if it is a
> problem). you have to filter task : chg_cst
> 
> this one is when the problem is happening using the computer display.
> 
> https://drive.google.com/open?id=0B1JEDrsMi1E1YkZja1dsWTFRcDQ
> 
> and this one is when it runs fine through a ssh -X session.
> https://drive.google.com/open?id=0B1JEDrsMi1E1WUVyOUFEbFdzWkk
> 
> comparing both tasks  diagram , I can sea that when it does not work,
> the task is interrupted for a long time.
> in other case, no interruption in it's activity diagram.

Interrupted by which activity, where, at which timestamp of this massive
trace file? Please give us accurate, detailed and precise information
for us to help, I don't think anyone on this list could invest much time
diving into a 95Mb trace dump.

-- 
Philippe.

