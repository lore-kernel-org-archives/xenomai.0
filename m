Message-ID: <5331B989.6060504@xenomai.org>
Date: Tue, 25 Mar 2014 18:14:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6781B7C7F03D8A4BAF673DC4478144C406908D51@XSERVER21A.campus.tue.nl>,
 <5331AB44.5070402@xenomai.org>
 <6781B7C7F03D8A4BAF673DC4478144C406908D6B@XSERVER21A.campus.tue.nl>
In-Reply-To: <6781B7C7F03D8A4BAF673DC4478144C406908D6B@XSERVER21A.campus.tue.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Switch to secondary mode due to pop/push into TBB
	queue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mnatsakanyan, M." <m.mnatsakanyan@tue.nl>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/25/2014 05:35 PM, Mnatsakanyan, M. wrote:
> Sorry if my question is not worthy to post here.
> I read a lot from xenomai documentation and discussions, but still cannot answer this question.

The threading building blocks consists of a huge amount of code not even 
remotely designed for running over a dual kernel system, so they issue 
regular linux system calls under the hood, either directly or indirectly 
by calling other library services. Not to speak of the C++ runtime which 
introduces its own set of issues.

In short, TBB won't care about a very basic Xenomai 2.x requirement: 
services in real-time mode (i.e. primary) should be obtained from 
Xenomai APIs, excluding regular linux system calls. One of these APIs is 
a subset of the POSIX specification aimed at real-time programming 
though, but this is likely not enough to cover every service the TBB 
invokes.

Diving into the TBB implementation would be required to figure out what 
happens there, and whether using a construct in real-time mode over a 
dual kernel is ever possible.

>
> ________________________________________
> From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
> Sent: Tuesday, March 25, 2014 5:13 PM
> To: Mnatsakanyan, M.
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Switch to secondary mode due to pop/push into TBB queue
>
> On 03/25/2014 05:03 PM, Mnatsakanyan, M. wrote:
>> Hello,
>>
>> I am trying to build a real-time application, but still do not understand all Xenomai concepts clearly,
>
> So, I suggest you read the documentation at http://www.xenomai.org
>
> --
>                                              Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.

