Message-ID: <fd064603-1ccc-5062-dbbe-e8f30377429a@siemens.com>
Date: Sat, 8 Jan 2022 10:56:27 +0100
MIME-Version: 1.0
Subject: Re: [xenomai-images][PATCH v4 0/8] Update CI and kconfig for next and
 stable/3.2.x
Content-Language: en-US
References: <cover.1641567783.git.jan.kiszka@siemens.com>
 <f132c881df231c0f13da4809c2d356b332873486.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f132c881df231c0f13da4809c2d356b332873486.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07.01.22 18:43, Bezdeka, Florian (T CED SES-DE) wrote:
> On Fri, 2022-01-07 at 16:02 +0100, Jan Kiszka via Xenomai wrote:
>> Changes in v4:
>>  - clean up CI variable interface and documentation
>>
>> This accounts for change in Xenomai next as well as the fork-off of
>> stable/3.2.x. And it simplifies our gitlab-ci configuration as bit.
> 
> Can we simplify conf/distro/include/xenomai-version.inc now as well?
> 

We cannot simplify it as long as we support 3.0 and 3.1 with the
recipes. We actually need to expand it when adding 5.15 kernel support
so that 3.2 picks 5.10 and head 5.15.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

