References: <1487178823-4062-1-git-send-email-tbultel@pixelsurmer.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d6015da2-8e58-22df-6790-661f811d4cdc@xenomai.org>
Date: Thu, 16 Feb 2017 10:19:25 +0100
MIME-Version: 1.0
In-Reply-To: <1487178823-4062-1-git-send-email-tbultel@pixelsurmer.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] automake: add a conditionnal to rt devices
 install
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <tbultel@pixelsurmer.com>, xenomai@xenomai.org

On 02/15/2017 06:13 PM, Thierry Bultel wrote:
> When cross building from a build system (like buildroot),
> it is not convenient to get the sudo prompt for the installation
> of cobalt rt devices.
> Calling mknod is the responsibility of the build system, that
> will perform it under a fakeroot environnement
> The fix simply checks the existence of NO_RT_DEVICES environment
> that can be set when bootstrapping
> ---
>  Makefile.am  | 2 ++
>  configure.ac | 2 ++
>  2 files changed, 4 insertions(+)
> 

Thanks, however this is duplicating an existing mechanism:

$ make SUDO=false install

see install-user rule in the toplevel Makefile.

This said, Xenomai 3 expects udev/mdev to be enabled, so most of the
devices rule in that Makefile is useless now; at least the install rule
should not implicitly chain to it via install-exec-local.

-- 
Philippe.

