Subject: Re: New developer accounts on source.denx.de
References: <c6949f70dd57687afaabeaf4c10879ae1c6ec8b2.camel@siemens.com>
 <939281.1614936935@gemini.denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <704eeb93-e101-fb54-c3a2-0d2183a95e62@siemens.com>
Date: Fri, 5 Mar 2021 10:48:59 +0100
MIME-Version: 1.0
In-Reply-To: <939281.1614936935@gemini.denx.de>
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
To: Wolfgang Denk <wd@denx.de>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "hws@denx.de" <hws@denx.de>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>, Philippe Gerum <rpm@xenomai.org>

On 05.03.21 10:35, Wolfgang Denk wrote:
> Dear Florian,
> 
> In message <c6949f70dd57687afaabeaf4c10879ae1c6ec8b2.camel@siemens.com> you wrote:
>>
>> as the new gitlab instance on source.denx.de is now available I would
>> like to apply for two developer accounts: One for myself and one for
>> Song (see CC), who is also contributing to Xenomai. 
>>
>> We both are working on the Y2038 topic and having such accounts would
>> simplify collaboration and contribution to the Xenomai projects. Beside
>> the xenomai project the xenomai-images project would be relevant for
>> us.
>>
>> The account creation for Quirin was on hold due to planned
>> infrastructure change. So hopefully you can now create all the accounts
>> at once.
> 
> I don't know how the Xenomai project is handling this, but I think
> it would be incorrect if we (DENX) would add just anybody who asks.
> In U-Boot, only custodians have write access to the repositories,
> and to become a custodian you have to apply for the role on the
> mailing list, and submit a patch that enters your data in the
> MAINTAINERS list.  This patch goes through the regular review
> process, so it is the community who finally decides who receives
> such priviledges.
> 
> As you did not even have Philippe on Cc:, I'm adding him here.
> 
> Philippe:  How does the assigment of roles / priviledges work for
> the Xenomai project?  Can / shall we grant the above request?
> 

The process shall be that frequent contributors (including supporters of
our CI/CT deployment) first of all get an account on source.denx.de.
That would allow them to create private trees (under their own
namespace) - analogously to public platforms - and benefit from our CI
(probably with my help as owner of the group the runners are assigned to).

Further on, it would allow me to add them as developer or even just
reporter to Xenomai to allow them to contribute to the wiki and issue
tracker. That is critical to improve collaboration.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

