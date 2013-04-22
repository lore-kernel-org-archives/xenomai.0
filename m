Message-ID: <5174F4E3.8030603@grandegger.com>
Date: Mon, 22 Apr 2013 10:29:23 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
	<516E336C.1060509@xenomai.org>
	<CADVgf9=CJ0MQEpsub3g=bDZvxk3U3G1tDDvjvFm1jZRmke35fg@mail.gmail.com>
	<CAD1EtoiQm8rZtkDTjZK8Tq3xeDKHULjc7V6Stg=bZ9XpEp5o7w@mail.gmail.com>
	<516F9E87.6020002@grandegger.com> <516FA077.20400@grandegger.com>
	<CAD1EtoiZ05S5HXEvdq2+Sg6-1XbxHwMUpcVMrpYA6gv0JgLqJw@mail.gmail.com>
	<5171069C.3020909@grandegger.com>
	<CAMsuG6pte10W8AbABnwAzLnVKF6kTRv+M5m2o=JE6z6oT_Qc4g@mail.gmail.com>
	<5171A299.60905@grandegger.com>
	<CAD1Etoi3iFSyWA_z4ex9T9=mbtHQyCkd0zR4Yq3Lf6e1NCu+0g@mail.gmail.com>
In-Reply-To: <CAD1Etoi3iFSyWA_z4ex9T9=mbtHQyCkd0zR4Yq3Lf6e1NCu+0g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 04/19/2013 10:09 PM, Daniel M. Drucker, Ph.D. wrote:
>>> do you guys think that it's interesting that rtcansendmulti supports
>>> same syntax than rtcanrecv output?
>>> To do for instance:
>>> rtcanrecv | rtcansendmulti -
>>
>> Good idea. Sounds useful.
> 
> I'm not sure how I'd reconcile that idea with:
> 
>> I would prefer removing -i, -r, -e, etc. and add it as data:
>>  s 0x601 0x40 0x41 0x60 0x00   (standard frame)
>>  e 0x12345678 0x40 0x41        (extended frame)
>>  sr 0x601                      (standard rtr frame)
>>  er 0x3456778                  (extended rtr frame)
> 
> I liked the format I came up with because it explicitly does NOT
> define any new syntax and does not require any kind of parsing beyond
> what rtcansend is already doing with getopt.

This method is not transparent/straight-forward, I feel. You mix various
things making the code more complex than necessary.

> Is there a good reason to define a new syntax? Using the syntax that

I still prefer a simple ascii base syntax describing the complete message.

> is the output of rtcanrecv would mean we couldn't have things like
> per-message delays.

You want to change the delay between messages as well? Anyway, the
output of rtcanrecv  is probably to awkward to convert.

Wolfgang.




> Daniel
> 
> 


