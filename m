Message-ID: <53BA90A6.3060402@xenomai.org>
Date: Mon, 07 Jul 2014 14:20:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53B512BB.9040908@ma-info.de>,
 <9fc8c769e5b64478942864724e979a74@EX132MBOX1B.de2.local>
 <4c01854d47444a33a7f360da922b422c@EX132MBOX1B.de2.local>
 <53BA8FBF.8060301@xenomai.org>
In-Reply-To: <53BA8FBF.8060301@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on PhyCore/Board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/07/2014 02:17 PM, Gilles Chanteperdrix wrote:
> On 07/07/2014 12:44 PM, Stoidner, Christoph wrote:
>> Hi Florian,
>>
>> we are also doing some latency tests on I-Pipe/Xenomai, pure Linux and Linux with Preempt RT.
>>
>> Are you interested to share our's and your results?
>>
>> We plan to publish the results when we have formatted them in a comprehensible way.
> 
> Note that the latency test has a -g option to output the histogram to a
> file, and that xenomai provides the xeno-test and dohell scripts to run
> a reproducible benchmark, and scripts/histo.gp to turn the histogram
> dumped with -g to a comprehensible graph.

xeno-test is documented here:
http://www.xenomai.org/documentation/xenomai-2.6/html/xeno-test/index.html

dohell is documented here:
http://www.xenomai.org/documentation/xenomai-2.6/html/dohell/index.html

-- 
                                                                Gilles.

