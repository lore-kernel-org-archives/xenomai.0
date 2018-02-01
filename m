From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <83a11fe5-fa49-7337-6b07-00715cd4837a@siemens.com>
Date: Thu, 1 Feb 2018 17:43:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] libs: Mode-switching notice/debug/warning/panic
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi,

it seems those functions above force the caller always to secondary mode
(ok, panic is not an issue). Intentionally? To avoid using the wrapped
versions which may trigger one of the calls again? Or could we also call
the RT versions, at least after init_done?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

