Subject: Re: [for-upstream/dovetail 1/2] drivers/gpio: core: introduce helper
 to find array of gpiochips
References: <20210513010238.32466-1-hongzhan.chen@intel.com>
 <20210513010238.32466-2-hongzhan.chen@intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9f1b8c2a-20b7-8353-9b79-bff26d79d71c@siemens.com>
Date: Tue, 18 May 2021 23:25:05 +0200
MIME-Version: 1.0
In-Reply-To: <20210513010238.32466-2-hongzhan.chen@intel.com>
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
To: hongzha1 <hongzhan.chen@intel.com>, xenomai@xenomai.org

On 13.05.21 03:02, hongzha1 via Xenomai wrote:
> To find array of gpiochips for non-OF platform
> 
> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

Just noticed that all your patches carry your user name in the
signed-off. You should fix that. Is this correct?

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

Also, please make sure that patches carry the extra "From: your name
<your@email>" at the top of the commit message. This list server has to
mangle the sender, and that means the author on git can become something
like "hongzha1 via Xenomai <xenomai@xenomai.org>". You can trigger this
injection by providing a dummy address via --from when calling git
format-patch.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

