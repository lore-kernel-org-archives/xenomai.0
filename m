From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com>
References: <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com>
Date: Fri, 23 Feb 2018 18:12:38 +0100
Message-Id: <20180223171238.A15B7240112@gemini.denx.de>
Subject: Re: [Xenomai] Winter^W y2038 is coming
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Dear Jan Kiszka,

In message <9d0a8dc6-d16d-e3e2-8d20-400e5e2e4b4c@siemens.com> you wrote:
> 
> I'm now wondering if we should take measures that detect or even prevent
> the setting of invalid dates in the presence of 32-bit ABIs. Or if we
> should suggest/demand the setting of -D_TIME_BITS=64 already. The clock
> is ticking... Thoughts?

As you well know, there are quite a few projects with product life
times of 20 years, so we really should start to raise awareness of
the y2038 problem.  In a case like this I think the best way is to
push forward for 64 bit time stamps.

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
At the source of every error which is blamed on the computer you will
find at least two human errors, including the error of blaming it  on
the computer.

