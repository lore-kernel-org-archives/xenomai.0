Subject: Re: [PATCH 0/9] Enable support for kernel 5.15
References: <cover.1634126152.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b0dc84b7-3846-644c-8cc2-a80410b2a1d4@siemens.com>
Date: Wed, 13 Oct 2021 13:59:58 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: xenomai@xenomai.org

On 13.10.21 13:55, Jan Kiszka via Xenomai wrote:
> Most of these are harmless conversions with backward-compatible
> wrappings. Only the last patch is a bit hairy as I'm unsure whether the
> new detection mechanism for vDSO VMAs is truly reliable. Therefore, this
> patch is not (yet?) targeting next, thus 3.2-rc2.
> 

Forgot to write: The result booted with v5.15-dovetail-rebase and
apparently worked fine. I'm just seeing strange issues with the virtual
VGA console in QEMU, likely upstream related and not an issue of
Dovetail or Xenomai.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

