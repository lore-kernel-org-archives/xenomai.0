Subject: Re: [PATCH v2] lib/boilerplate/iniparser: Allow building with GCC
 10.2 2020101
References: <0481e0339de9eb16e4460bb2b97d4b2e2f0f1148.camel@siemens.com>
 <20201112114510.60332-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0511e991-534e-8bef-2fb0-a7a94c506f32@siemens.com>
Date: Thu, 12 Nov 2020 17:19:44 +0100
MIME-Version: 1.0
In-Reply-To: <20201112114510.60332-1-florian.bezdeka@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12.11.20 12:45, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> From: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> Updating to upstream revision f858275f7f307eecba84c2f5429483f9f28007f8.
> 
> The reason for updating was the following compiler error when trying
> to compile with GCC 10.2 10.2.1 20201016. As it turned out the problem
> was already addressed upstream:
> 
> iniparser/iniparser.c: In function ‘iniparser_load’:
> iniparser/iniparser.c:616:13: error: ‘sprintf’ arguments 3, 4 may
> overlap destination object ‘buf’ [-Werror=restrict]
>    616 |             sprintf(tmp, "%s:%s", section, key);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I reviewed especially the API changes. Most of them are cleanups only
> but two things should be pointed out:
> 
>   - The type of the size field of struct _dictionary_ changed from int
>     to ssize_t. The only user of this struct is
>     lib/analogy/calibration.c which uses this structure for internal
>     things only. It is never exposed to any public API so updating is
>     OK and fully backward compatible.
> 
>   - dictionary_new changed its signature
>       from dictionary_new(int size)
>       to   dictionary_new(size_t size).
>     This function is not part of any public API. So updating does not
>     break backward compatibility.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/boilerplate/iniparser/dictionary.c | 409 ++++++++++----------
>  lib/boilerplate/iniparser/dictionary.h |  43 ++-
>  lib/boilerplate/iniparser/iniparser.c  | 491 +++++++++++++++++--------
>  lib/boilerplate/iniparser/iniparser.h  | 131 +++++--
>  4 files changed, 646 insertions(+), 428 deletions(-)
> 

Thanks, applied to next (after sorting out our Siemens-local mail
transfer problem...).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


