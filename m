References: <2396B4D2166B62479FBBE370D4A7C1F30A723600@mb2010-3.intra.tut.fi>
From: Jorge Ramirez Ortiz <jro@xenomai.org>
Message-ID: <56DF046E.6030708@xenomai.org>
Date: Tue, 8 Mar 2016 11:57:18 -0500
MIME-Version: 1.0
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A723600@mb2010-3.intra.tut.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.1 kernel timer example
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/04/2016 09:00 AM, Umair Ali wrote:
> Hello there,
> 
> I am searching for the example of the Xenomai 3.0.1 kernel timer. I want to know how I can write the basic code of the kernel timer. 

have a look at this example (pwm signal generator)
http://git.xenomai.org/xenomai-jro.git/tree/?h=hikey

it is controlled from:
http://git.xenomai.org/xenomai-jro.git/tree/kernel/drivers/gpiopwm/gpiopwm.c?h=hikey


> 
-- 
jro

