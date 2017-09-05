References: <f61b6963a0f94bd0a09eb5eb359370e5@ocnapvsw3301.ocr.priv>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <425b607a-6b79-420c-9ec1-e441f6a1434e@xenomai.org>
Date: Tue, 5 Sep 2017 20:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <f61b6963a0f94bd0a09eb5eb359370e5@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 2.6.4 - POSIX skin thread creation limit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/05/2017 05:39 PM, Fazio Maurizio wrote:
> Hello,
> is there a thread creation limit using the POSIX skin of Xenomai 2.6.4???
> After about 20 pthread_create invocation, the function returns -1…

Check
http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#pthread_create_Resource_temporarily_unavailable
CONFIG_XENO_OPT_SEM_HEAPSZ might need an increase too.

Just in case this remark applies to your case: please do not base a new
project on the EOL 2.6 series, this is asking for troubles
maintenance-wise. Besides, 2.6.5 was the latest 2.6.x to be released.

-- 
Philippe.

