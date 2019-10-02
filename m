Subject: Re: Dovetail status clarification
References: <CABaOOZ0nqvBR+PMCWvZieY+b3j3nAcq_0FVSY42F0FjcXKD_hQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44151481-b9f7-24a4-252a-bb91138f336a@siemens.com>
Date: Wed, 2 Oct 2019 10:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <CABaOOZ0nqvBR+PMCWvZieY+b3j3nAcq_0FVSY42F0FjcXKD_hQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Stratiyenko Roman <picoworm@gmail.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 02.10.19 09:06, Stratiyenko Roman via Xenomai wrote:
> Hello xenomai community,
> 
> As you may already know kernel v5.4-rc1 released yesterday and according to
> releases page on kernel.org this version is LTS.
> 
> So it make sense to start porting of xenomai to this release.
> 
> Some time ago dovetail were announced and It should replace ipipe for
> xenomai.
> 
> Do you have any plans to start this migration in nearest time?

This is indeed a good question at the right time. Philippe can tell more details 
about the dovetail status. There are prototypes for ARM and x86 for Xenomai, but 
I didn't find time to test at least the x86 part so far. We should definitely 
look into this now before moving forward.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

