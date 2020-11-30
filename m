Subject: Re: [xenomai patch with kernel 5.4.77] Error building the kernel
References: <CADx0-8DU+evLr-SduY9ru9zKBuhqjYOHPZ=5U4wFnMZAhE5irA@mail.gmail.com>
 <7786a8bf14ab25145e468bba2b567da76e9fd048.camel@siemens.com>
 <CADx0-8C7CW4i+O7g4zAGE0uXtD+bnNr4oR8HF-_tNArpteSDmQ@mail.gmail.com>
 <3afd98886487b064501e173f4e8d811f3f1a61f1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <abe234e7-b15d-d257-69bc-c9e1ccd6898a@siemens.com>
Date: Mon, 30 Nov 2020 14:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <3afd98886487b064501e173f4e8d811f3f1a61f1.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "m.mohamedirfanulla@gmail.com" <m.mohamedirfanulla@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 30.11.20 13:41, florian.bezdeka--- via Xenomai wrote:
> On Mon, 2020-11-30 at 12:16 +0100, Mohamed Irfanulla Mohamed Abdulla
> wrote:
>> Thank you for your reply. 
>> I find that I use the wrong branch. Could you please suggest a good
>> branch that I can use?
>>
> 
> I'm quite new to the Xenomai project, so don't trust me ;-)
> 
> The problem you are facing was "fixed" in commit 
> 608c23297c4d ("cobalt/x86: Account for FPU changes in kernel 5.2") 
> which is part of the "next" branch.
> 
> It looks like kernels >= 5.2 are not supported in official releases /
> branches yet.

Correct. Next 3.1.x release will include that. Until then you need a
version from git.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

