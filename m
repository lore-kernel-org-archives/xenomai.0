References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
 <20160620171848.GB18662@hermes.click-hack.org>
 <44h9cmz8y1.fsf@be-well.ilk.org> <44eg7i1x8y.fsf@be-well.ilk.org>
 <44ziq6ze1c.fsf@be-well.ilk.org>
 <CAMcKmiFjiUv7bChKbVgwKg-Nx7aFqy3=H6ph55Vcv98cOSXexQ@mail.gmail.com>
 <DB6PR0601MB21674058568F45BD554818828FEB0@DB6PR0601MB2167.eurprd06.prod.outlook.com>
 <CAMcKmiH1-0WajO4S3k0M3qzNTRyg=Lx_L0ofWuypKBE_f+waLw@mail.gmail.com>
 <593d9818-17fb-c7a7-ebcf-ab801d73499a@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <7a06a7b5-7d52-c192-b8ce-a3e2a77ea805@xenomai.org>
Date: Wed, 24 Aug 2016 12:29:04 +0200
MIME-Version: 1.0
In-Reply-To: <593d9818-17fb-c7a7-ebcf-ab801d73499a@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Broz <brozgeo@gmail.com>, Alex Plits <alex_plits@radwin.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/24/2016 12:14 PM, Philippe Gerum wrote:
> On 08/24/2016 02:35 AM, George Broz wrote:
>> On 23 August 2016 at 10:14, Alex Plits <alex_plits@radwin.com> wrote:
>>> Hi,
>>>
>>> Had the same issue (ARMv7/Cobalt/3.0.2), did not find any solution, fail back to debugging using the SIGDEBUG signaling catching.
>>>
>>> Best Regards,
>>> Alex Plits.
>>>
>>> -----Original Message-----
>>
>> Thanks.
>>
>> Has anyone out there successfully run slackspot on ARM? After a day of
>> trying with a very simple single task example, I'm giving up.
>>
>> Regarding SIGDEBUG - I started with the code from here:
>>
>> https://xenomai.org/2014/06/finding-spurious-relaxes/
>>
>> but found I had to change signal(sig, SIG_DFL); to signal(sig,
>> SIG_IGN); to prevent the application from exiting on the first
>> instance
>> of a (non-lethal) secondary transition (and using sigdebug_reason(si)
>> to return the correct code). With SIG_IGN, the application does
>> not terminate, but the SIGDEBUG handler is not invoked for subsequent
>> secondary transition events (as indicated by the MSW counter).
>>
>> Is there a trick to catching multiple SIGDEBUG events on the same task?
>>
>>
> 
> Yes, just don't change the re-trap the signal in the handler, leave it

Wow, ok, please read: just don't re-trap the signal in the handler.

-- 
Philippe.

