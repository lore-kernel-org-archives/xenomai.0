References: <55AE3AAB.5070403@siemens.com> <55AE4068.5050102@xenomai.org>
 <55AE5D0B.60300@siemens.com> <55B0A89B.5020004@xenomai.org>
 <55B0AEFE.5080202@siemens.com> <55B0B268.7020209@xenomai.org>
 <55B0EE25.1030609@siemens.com> <55B1446A.2080406@xenomai.org>
 <55B1E813.1030705@xenomai.org> <55B20D4C.7000103@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55B22CE4.1010907@siemens.com>
Date: Fri, 24 Jul 2015 14:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <55B20D4C.7000103@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: comapt issues with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-07-24 12:02, Philippe Gerum wrote:
> Pushed to -next, and tested over 32 and 3264 ABI models over x86. This
> breaks the ABI, so both kernel and userland have to be rebuilt. The bad
> news is that I now have to redo all the testing on all other archs. Oh
> well, ...

Was tested here (except for the new *64 calls) and works well, thanks!

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

