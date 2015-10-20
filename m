References: <20150909113151.0fed6fd7@md1em3qc> <55F02DB0.1090801@xenomai.org>
 <20150915104854.56a7b13f@md1em3qc>
 <20150917143955.01a71eb6@md1em3qc>
 <561ED42E.5080608@xenomai.org> <562658C0.8090006@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56265F30.1030308@xenomai.org>
Date: Tue, 20 Oct 2015 17:35:12 +0200
MIME-Version: 1.0
In-Reply-To: <562658C0.8090006@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.x merge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>, Henning Schild <henning.schild@siemens.com>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/20/2015 05:07 PM, Jorge Ramirez Ortiz wrote:
> On 10/14/2015 06:16 PM, Jorge Ramirez Ortiz wrote:
>>
>>>
>>> I did push my current state to github. Check out 
>>> https://github.com/siemens/linux-ipipe
>>> branches ipipe-3.19 and -4.0
>>
>>
>>
>> I just noticed -while reusing some of your changes for aarch64 - that his needs
>> fixing (redeclaration of 'flags')
>> https://github.com/siemens/linux-ipipe/blob/ipipe-4.0/drivers/irqchip/irq-gic.c#L270
>>
> 
> Hi Henning,
> 
> have you tried running the switchtest with the boot parameter
> xenomai.supported_cpus=0x1?
> 
> 
> 

That won't work, switchtest attempts to spread the rt test load over all
online CPUs, which your kernel setting contradicts.

-- 
Philippe.

