From: Wolfgang Denk <wd@denx.de>
Subject: Re: New developer accounts on source.denx.de
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
In-reply-to: <c6949f70dd57687afaabeaf4c10879ae1c6ec8b2.camel@siemens.com>
References: <c6949f70dd57687afaabeaf4c10879ae1c6ec8b2.camel@siemens.com>
Date: Fri, 05 Mar 2021 10:35:35 +0100
Message-ID: <939281.1614936935@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "hws@denx.de" <hws@denx.de>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>, Philippe Gerum <rpm@xenomai.org>

Dear Florian,

In message <c6949f70dd57687afaabeaf4c10879ae1c6ec8b2.camel@siemens.com> you wrote:
> 
> as the new gitlab instance on source.denx.de is now available I would
> like to apply for two developer accounts: One for myself and one for
> Song (see CC), who is also contributing to Xenomai. 
> 
> We both are working on the Y2038 topic and having such accounts would
> simplify collaboration and contribution to the Xenomai projects. Beside
> the xenomai project the xenomai-images project would be relevant for
> us.
> 
> The account creation for Quirin was on hold due to planned
> infrastructure change. So hopefully you can now create all the accounts
> at once.

I don't know how the Xenomai project is handling this, but I think
it would be incorrect if we (DENX) would add just anybody who asks.
In U-Boot, only custodians have write access to the repositories,
and to become a custodian you have to apply for the role on the
mailing list, and submit a patch that enters your data in the
MAINTAINERS list.  This patch goes through the regular review
process, so it is the community who finally decides who receives
such priviledges.

As you did not even have Philippe on Cc:, I'm adding him here.

Philippe:  How does the assigment of roles / priviledges work for
the Xenomai project?  Can / shall we grant the above request?

TIA.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Unix: Some say the learning curve is steep,  but  you  only  have  to
climb it once.                                      - Karl Lehenbauer

