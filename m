Message-ID: <5108FED0.6030709@xenomai.org>
Date: Wed, 30 Jan 2013 12:06:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5108FABD.8090401@sirius-es.it> <5108FB91.2040105@xenomai.org>
In-Reply-To: <5108FB91.2040105@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FPU problems in Xenomai 2.4.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Cc: xenomai@xenomai.org

On 01/30/2013 11:53 AM, Philippe Gerum wrote:
> On 01/30/2013 11:49 AM, Matteo Facchinetti wrote:
>> Hi,
>>
>> in a PPC mpc5125 system we're using xenomai 2.4.x (from git repository)
>
> 2.4.x is no more supported since ages. Besides, we don't support mpc512x
> over this release for sure.
>

Well, yes actually we did support this one in 2.4.x. I did a port to the 
5121_ADS close to the end of the 2.4.x maintenance cycle late in 2008. 
Time flies...

Assuming you really have to stick with linux 2.6.29, I would strongly 
suggest to move to Xenomai 2.6.2.1, backporting all FPU related fixes 
you may find in our repo for the interrupt pipeline to this release. 
Upgrading your kernel to 2.6.36 at least would be your best technical 
option though.

To sum up:

- linux 2.6.29 + fpu management fixes + Xenomai 2.6.2.1
or,
- linux >= 2.6.36[.4] + Xenomai 2.6.2.1

But you really don't want to fiddle with 2.4.x anymore.

-- 
Philippe.

