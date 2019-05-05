Subject: Re: I-pipe / Dovetail news
References: <24c08bcc-b152-ab0f-a92d-c990a780e90b@xenomai.org>
 <42084690.gCXjLoF4x3@omoikane>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8bd39842-dd24-6008-259d-6e6694c1df2a@xenomai.org>
Date: Sun, 5 May 2019 18:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <42084690.gCXjLoF4x3@omoikane>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <steven.seeger@flightsystems.net>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>, Dmitriy Cherkasov <dmitriy@oss-tech.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>

On 5/3/19 5:49 PM, Steven Seeger wrote:
> On Thursday, May 2, 2019 12:46:37 PM EDT Philippe Gerum wrote:
>> At the end of this process, a Dovetail-based Cobalt core should be
>> available for the ARM, ARM64 and x86_64 architectures. The port is made
>> in a way that enables the Cobalt core to interface with either the
>> I-pipe or Dovetail at build time. ppc32 is likely to follow at some
>> point if Steven is ok with this. I could probably help with that, I
>> still have my lite52xx workhorse around, and a few 40x and 44x SoCs
>> generously offered by Denx Engineering (thanks Wolfgang).
> 
> Philippe, I'm ok with helping. Honestly I am thinking that it may be beneficial 
> for us to move to Dovetail since an arinc-653 implementation on top of EVL 
> might be simpler to cerify that one on top of Cobalt. Plus, it should be more 
> efficient since we'd lose a compatibility layer. I'm going to be sending an 
> email to my co-workers here shortly about the topic.
> 
> I figured the first step would be a dovetail port. Are you suggesting you'd 
> rather, if I have time to help, prioritize my helping with a Cobalt over EVL 
> port on ppc32?
> 

You don't have to pick any real-time core at this stage for porting
Dovetail to another architecture. Enabling the interrupt pipeline
machinery is about 90% of the effort, and that part can be validated
using the built-in torture tests which come with Dovetail
(CONFIG_IRQ_PIPELINE_TORTURE_TEST).

Once these tests pass, you will need to port the so-called "alternate
task scheduling" support [1], which can only be validated using a
functional real-time core. When you get there, you can choose which core
you want to run over your Dovetail port, either Cobalt or EVL.

[1] https://www.evenless.org/dovetail/altsched/

-- 
Philippe.

