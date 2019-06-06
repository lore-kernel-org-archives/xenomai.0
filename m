Subject: Re: Finalizing 3.0.9 release
References: <39bd9ede-855c-6a06-73e5-8a79077e6a65@siemens.com>
 <CAO460_8njN+u9e92Eq-4sM_tOUdxv9xF23pO8P1zhziodmJ1Ew@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7456b7b1-fb42-cf09-2464-7671a9169d76@siemens.com>
Date: Thu, 6 Jun 2019 12:59:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAO460_8njN+u9e92Eq-4sM_tOUdxv9xF23pO8P1zhziodmJ1Ew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: "Stephen D. Cohen" <steve@uscohens.com>
Cc: Xenomai <xenomai@xenomai.org>

Hi Stephen,

On 06.06.19 12:43, Stephen D. Cohen wrote:
> Jan,
> 
>       Some months back I provided patches to make slackspot work properly for 
> PIE and to repair an issue with multiple spot sites in one object. I do not see 
> it applied in the archive at all.
> 

Thanks for the reminder. I guess I missed that due to some suboptimal format 
issues. Could you please ensure that

  - the patch subject carries a [patch] tag
  - has a subject line that summarized the change
  - has a commit log that briefly describes the "why", to
    document the commit (should be easy to derive from your explanation)
  - has a signed-off-by to document license conformance

See also CONTRIBUTING.md.

If your mail client prevents to format the mail properly and you cannot use git 
send-email directly, attaching is ok.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

