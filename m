Message-ID: <4E60A054.30101@domain.hid>
Date: Fri, 02 Sep 2011 11:22:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <509DA52866E38F47878413CF102D751FED236D7830@domain.hid>	
	<4E5F6E41.1050606@domain.hid>	
	<509DA52866E38F47878413CF102D751FED236D7834@domain.hid>	
	<4E5F753C.8070904@domain.hid>	
	<509DA52866E38F47878413CF102D751FED236D783D@poseidon.nexus-ag.com>	
	<4E5F9FDB.5080702@domain.hid>	
	<509DA52866E38F47878413CF102D751FED236D783F@poseidon.nexus-ag.com>	
	<1314908857.18201.28.camel@domain.hid>	
	<509DA52866E38F47878413CF102D751FED236D784C@poseidon.nexus-ag.com>
	<1314950450.22237.14.camel@domain.hid>
In-Reply-To: <1314950450.22237.14.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

On 09/02/2011 10:00 AM, Philippe Gerum wrote:
> On Fri, 2011-09-02 at 09:29 +0200, Sambasiva Rao Manchili wrote:
>> Thank you Philippe for your time.
>> Right now I did a workaround with a flag  after deleting a task and checking this flag before doing any operation by task that was deleted. It works for me.
>> I could not believe  taskDelete did not work till yesterday.
> 
> A kernel change has not been propagated to the vxworks library years
> ago. In the absence of user feedback and vxworks-specific testsuite in
> Xenomai 2.x, we are blind.
> 
>>
>> I hope with next version of Xenomail release the tested patch for taskDelete will be available and for now I live with my workaround.
>>
>> Overall porting of VxWorks code, Integration and testing since three months. I faced only two issues for which I got blocked.
>> 1. semTake with specific timeout value failed in Xenomai.  As a workaround I just removed this semTake and semGive , which is also OK to an extent in this area of code.
> 
> Unlike the one with taskDelete(), this sema4 issue is surprising to me.
> Can you elaborate?

The issue was discussed here:
https://mail.gna.org/public/xenomai-help/2011-08/msg00021.html

-- 
					    Gilles.

