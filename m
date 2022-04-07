Message-ID: <e9adcf9d-47e4-cf99-0227-d66c91a61149@siemens.com>
Date: Thu, 7 Apr 2022 11:30:16 +0200
MIME-Version: 1.0
Subject: Re: pthread_cancel services not documented
Content-Language: en-US
References: <CAKcohPwheCLCT-h-itxuL_Lc0qEZr6KG8e=YGX14Ne=nT40Cfw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAKcohPwheCLCT-h-itxuL_Lc0qEZr6KG8e=YGX14Ne=nT40Cfw@mail.gmail.com>
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
To: Yunjie Gu <yunjie.gu1@gmail.com>, xenomai@xenomai.org

On 07.04.22 10:20, Yunjie Gu via Xenomai wrote:
> Hi All,
> 
> I'm trying to use xenomai with posix interface, and I found some
> differences in the documentation for xenomai 2 and xenomai 3. In xenomai
> 2, pthread_cancel related services (including pthread_setcancelstate, .etc)
> are clearly documented. In xenomai 3, however, only pthread_kill is
> documented, but it seems other services are still there in source codes. My
> guessing is that pthread_cancel related services are managed by the linux
> rather than cobalt core and therefore were not explicitly documented in
> xenomai 3, and we can use them in the same way as we do in linux. Can
> anyone confirm this? See link below
> 
> https://xenomai.org/documentation/xenomai-2.6/html/api/group__posix__cancel.html
> 
> https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__thread.html#gae1a96424296ef872696c7fb90a8ae9aa
> 

Yes, only Xenomai-wrapped pthread services appear in the documentation.
You can use consider other service available, but those will generally
work by migrating the caller first to Linux mode.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

