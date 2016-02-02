References: <1453821607-20836-1-git-send-email-henning.schild@siemens.com>
 <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <56A9F314.9030808@xenomai.org> <20160128215313.7717dafb@md1em3qc>
 <56AB9D2B.1030905@xenomai.org> <20160129183948.GE24550@hermes.click-hack.org>
 <20160202130849.44ee20d5@md1em3qc> <56B0B611.4070505@xenomai.org>
 <20160202173849.1a5e43fc@md1em3qc>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56B0DBA5.100@siemens.com>
Date: Tue, 2 Feb 2016 17:39:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160202173849.1a5e43fc@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2016-02-02 17:38, Henning Schild wrote:
> Maybe a HAVE_ARCH_HUGE_VMAP depends on !IPIPE would also be fine?

No, no, that's a needless restriction. We need to fix I-pipe here.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

