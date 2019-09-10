Subject: Re: [PATCH 0/2] Debian build
References: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45740e28-7133-a8cc-ec62-a258025403f8@siemens.com>
Date: Tue, 10 Sep 2019 13:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
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

On 09.09.19 17:28, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add missing dependencies for xeno-test and add missing
>   bootstrap step to build a debian package.
> 
> Quirin Gylstorff (2):
>    debian/control: Add dependencies for xenomai-testsuite
>    debian/rules: Add missing bootstrap step
> 
>   debian/control | 2 +-
>   debian/rules   | 7 ++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

