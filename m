Subject: Re: Ftrace for Xenomai 3
References: <CAFc1U0sBrAbhuNe6Zy-C861Nxc_xB5uyV=93WK3c4JbUpNXiSQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7001086b-fe6c-5ecb-c3e1-744e691d3f08@siemens.com>
Date: Fri, 2 Aug 2019 10:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAFc1U0sBrAbhuNe6Zy-C861Nxc_xB5uyV=93WK3c4JbUpNXiSQ@mail.gmail.com>
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
To: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai@xenomai.org

On 02.08.19 09:37, Pierre FICHEUX via Xenomai wrote:
> Hi all,
> 
> I read in an article (in french) by Philippe that Ftrace was available for
> Xenomai 3.
> 
> https://connect.ed-diamond.com/Open-Silicium/OS-016/Xenomai-3-hybride-et-cameleon
> 
> "Si Ftrace l'a été (porté) pour Xenomai, d'autres manquent encore
> cruellement, comme Perf  et Valgrind "
> 
> -> approximative translation to  english:
> 
> "Ftrace was ported to Xenomai but some tools such as Perf and Valdgrind are
> still missing"
> 
> So what about Ftrace ?

Just try trace-cmd record -e "cobalt_*". We also have some plugin for
Kernelshark here, but that needs a refresher with the release 1.0 (baseline was
once kindly provided by Steven and his folks).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

