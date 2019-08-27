Subject: Re: [xenomai-images][PATCH 0/3] Update for ci
References: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fdb90082-4102-e7c5-1dda-b35f0b252b8a@siemens.com>
Date: Tue, 27 Aug 2019 11:15:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190827090752.13072-1-Quirin.Gylstorff@siemens.com>
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 27.08.19 11:07, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add all supported targets to ci and mention the targets in README.
> Fix arm64 builds in ci.
> 
> Quirin Gylstorff (3):
>    README: Add subsection physical targets
>    ci: Add new boards to ci
>    distro/include: Allow overwrite PREFERRED_VERSION
> 
>   .gitlab-ci.yml                          | 18 ++++++++++++++----
>   README.md                               |  7 ++++++-
>   conf/distro/include/xenomai-version.inc |  2 +-
>   3 files changed, 21 insertions(+), 6 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

