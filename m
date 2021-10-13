Subject: Re: [xenomai-images][PATCH v2 3/8] kas: Introduce kas option file for
 CI builds
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
 <20211013121732.140595-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4904b421-4c6a-91d7-5ff0-14066517ab04@siemens.com>
Date: Wed, 13 Oct 2021 14:22:10 +0200
MIME-Version: 1.0
In-Reply-To: <20211013121732.140595-4-florian.bezdeka@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org

On 13.10.21 14:17, Florian Bezdeka wrote:
> For now the difference between the demo and the "ci image" is the
> removed sshd-regen-keys. That reduces the (first) boot time especially
> on low end CI hardware. Helps to stay within LAVA timeouts.
> 
> CI builds will now use that file.
> 

Too many options. Can't we consolidate over a single CI/CT thing that
also includes the changes for ci-board?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

