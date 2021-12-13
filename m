Date: Mon, 13 Dec 2021 22:36:44 +0100 (CET)
From: Dario Binacchi <dariobin@libero.it>
Message-ID: <98350690.146797.1639431404063@mail1.libero.it>
In-Reply-To: <f679f55b-1dc5-9efd-d9aa-30cb613a33b1@siemens.com>
References: <20211212115611.3036-1-dariobin@libero.it>
 <20211212115611.3036-2-dariobin@libero.it>
 <a7f52d5d-92b4-60a9-8373-13ee105089f7@siemens.com>
 <f679f55b-1dc5-9efd-d9aa-30cb613a33b1@siemens.com>
Subject: Re: [PATCH v4 1/8] lib/smokey: add smokey_{modprobe,rmmod} helpers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org
Cc: "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Gianluca Falavigna <gianluca.falavigna@inwind.it>

Hi Jan,

> Il 13/12/2021 13:11 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:
> 
>  
> On 13.12.21 11:43, Jan Kiszka via Xenomai wrote:
> > On 12.12.21 12:56, Dario Binacchi wrote:
> >> Both functions, implemented and used for the net, are general purpose
> >> and therefore can be useful in other parts of the application with the
> >> application of minimal changes.
> >>
> >> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> >>
> >> ---
> >>
> >> Changes in v4:
> >> - Add the patch to the series.
> >>
> >>  include/smokey/smokey.h             |  6 +-
> >>  lib/smokey/helpers.c                | 99 +++++++++++++++++++++++++++++
> >>  testsuite/smokey/net_common/setup.c | 68 +-------------------
> >>  3 files changed, 106 insertions(+), 67 deletions(-)
> >>
> >> diff --git a/include/smokey/smokey.h b/include/smokey/smokey.h
> >> index 185fd3a8b..0ac1e8df4 100644
> >> --- a/include/smokey/smokey.h
> >> +++ b/include/smokey/smokey.h
> >> @@ -254,7 +254,11 @@ int smokey_barrier_timedwait(struct smokey_barrier *b,
> >>  void smokey_barrier_release(struct smokey_barrier *b);
> >>  
> >>  int smokey_fork_exec(const char *path, const char *arg);
> >> -	
> >> +
> >> +int smokey_modprobe(const char *name, bool silent);
> >> +
> >> +int smokey_rmmod(const char *name);
> >> +
> >>  #ifdef __cplusplus
> >>  }
> >>  #endif
> >> diff --git a/lib/smokey/helpers.c b/lib/smokey/helpers.c
> >> index da84c863c..dc0bb5d0c 100644
> >> --- a/lib/smokey/helpers.c
> >> +++ b/lib/smokey/helpers.c
> >> @@ -292,3 +292,102 @@ int smokey_fork_exec(const char *path, const char *arg)
> >>  	return 1;
> >>  
> >>  }
> >> +
> >> +#define SMOKEY_MOD_NUM       32
> >> +static char *smokey_modules[SMOKEY_MOD_NUM];
> >> +
> >> +int smokey_modprobe(const char *name, bool silent)
> >> +{
> >> +	char buffer[128];
> >> +	int err, len, i, midx = -1;
> >> +	FILE *fp;
> >> +
> >> +	fp = fopen("/proc/modules", "r");
> >> +	if (fp == NULL)
> >> +		return -errno;
> >> +
> >> +	len = strlen(name);
> >> +
> >> +	while (fgets(buffer, sizeof(buffer), fp)) {
> >> +		if (strncmp(buffer, name, len) == 0 &&
> >> +		    len < sizeof(buffer) && buffer[len] == ' ') {
> >> +			smokey_trace("%s module already loaded", name);
> >> +			fclose(fp);
> >> +			return 0;
> >> +		}
> >> +	}
> >> +
> >> +	fclose(fp);
> >> +
> >> +	for (i = 0; i < SMOKEY_MOD_NUM; i++) {
> >> +		if (!smokey_modules[i]) {
> >> +			midx = i;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	if (midx < 0)
> >> +		return -EFAULT;
> >> +
> >> +	smokey_trace("%s module not there: modprobing", name);
> >> +
> >> +	err = smokey_check_errno(
> >> +		snprintf(buffer, sizeof(buffer), "modprobe %s %s", name,
> >> +			 silent ? "2>/dev/null" : ""));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	err = smokey_check_errno(system(buffer));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
> >> +		if (!silent)
> >> +			smokey_warning("%s: abnormal exit", buffer);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	smokey_modules[midx] = strdup(name);
> >> +	return 0;
> >> +}
> >> +
> >> +int smokey_rmmod(const char *name)
> >> +{
> >> +	char buffer[128];
> >> +	int i, midx = -1, err;
> >> +
> >> +	if (!name)
> >> +		return -EINVAL;
> >> +
> >> +	for (i = 0; i < SMOKEY_MOD_NUM; i++) {
> >> +		if (smokey_modules[i] && !strcmp(smokey_modules[i], name)) {
> >> +			midx = i;
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	if (midx < 0) {
> >> +		smokey_trace("%s module was there on entry, keeping it", name);
> >> +		return 0;
> >> +	}
> >> +
> >> +	smokey_trace("unloading %s module", name);
> >> +
> >> +	err = smokey_check_errno(
> >> +		snprintf(buffer, sizeof(buffer), "rmmod %s", name));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	err = smokey_check_errno(system(buffer));
> >> +	if (err < 0)
> >> +		return err;
> >> +
> >> +	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
> >> +		smokey_warning("%s: abnormal exit", buffer);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	free(smokey_modules[midx]);
> >> +
> >> +	return err;
> >> +}
> >> diff --git a/testsuite/smokey/net_common/setup.c b/testsuite/smokey/net_common/setup.c
> >> index 44a0cb24b..f97c14823 100644
> >> --- a/testsuite/smokey/net_common/setup.c
> >> +++ b/testsuite/smokey/net_common/setup.c
> >> @@ -28,7 +28,6 @@
> >>  struct module {
> >>  	int option;
> >>  	const char *name;
> >> -	bool loaded;
> >>  };
> >>  
> >>  #define TIMEOUT 10
> >> @@ -141,81 +140,18 @@ static int do_down(const char *intf)
> >>  static int smokey_net_modprobe(int modid, bool silent)
> >>  {
> >>  	struct module *m = modules + modid;
> >> -	char buffer[128];
> >> -	int err, len;
> >> -	FILE *fp;
> >>  
> >>  	if (modid < 0)
> >>  		return -EINVAL;
> >>  
> >> -	fp = fopen("/proc/modules", "r");
> >> -	if (fp == NULL)
> >> -		return -errno;
> >> -
> >> -	len = strlen(m->name);
> >> -
> >> -	while (fgets(buffer, sizeof(buffer), fp)) {
> >> -		if (strncmp(buffer, m->name, len) == 0 &&
> >> -		    len < sizeof(buffer) && buffer[len] == ' ') {
> >> -			smokey_trace("%s module already loaded", m->name);
> >> -			fclose(fp);
> >> -			return 0;
> >> -		}
> >> -	}
> >> -
> >> -	fclose(fp);
> >> -
> >> -	smokey_trace("%s module not there: modprobing", m->name);
> >> -
> >> -	err = smokey_check_errno(
> >> -		snprintf(buffer, sizeof(buffer), "modprobe %s %s", m->name,
> >> -			 silent ? "2>/dev/null" : ""));
> >> -	if (err < 0)
> >> -		return err;
> >> -
> >> -	err = smokey_check_errno(system(buffer));
> >> -	if (err < 0)
> >> -		return err;
> >> -
> >> -	if (!WIFEXITED(err) || WEXITSTATUS(err) != 0) {
> >> -		if (!silent)
> >> -			smokey_warning("%s: abnormal exit", buffer);
> >> -		return -EINVAL;
> >> -	}
> >> -
> >> -	m->loaded = true;
> >> -
> >> -	return err;
> >> +	return smokey_modprobe(m->name, silent);
> >>  }
> >>  
> >>  static int smokey_net_rmmod(int modid)
> >>  {
> >>  	struct module *m = modules + modid;
> >> -	char buffer[128];
> >> -	int err;
> >> -
> >> -	if (!m->loaded) {
> >> -		smokey_trace("%s module was there on entry, keeping it", m->name);
> >> -		return 0;
> >> -	}
> > 
> > Reverting the series again: You broke the handling of already loaded (or
> > built-in) modules, also for the rtnet tests.
> > 
> > With CAN, you now get e.g.
> > 
> > 2021-12-13T09:36:48 rmmod: ERROR: Module xeno_can_virt is builtin.
> > 2021-12-13T09:36:48 helpers.c:386, rmmod xeno_can_virt: abnormal exit
> > 2021-12-13T09:36:48 rmmod: ERROR: Module xeno_can is builtin.
> > 2021-12-13T09:36:48 helpers.c:386, rmmod xeno_can: abnormal exit
> > 
> 
> Strangely, I'm getting the error that already modprobe fails in another
> setup (qemu-arm64 of xenomai-images) if those things are built-in.
> 
The smokey_net_modprobe() will not call the modprobe command if it finds 
the module in /proc/modules, but in case of a builtin mnodule, the modprobe
will be called and it will fail (this was the behaviour even before my change). 
In fact, the return value of smokey_net_modprobe(MODID_RTNET, true); in 
testsuite/smokey/net_common/setup.c is not checked. 
IMHO I can call smokey_modprobe(CAN_MOD, true); and smokey_modprobe(CAN_VIRT_MOD, true); 
without checking the return value.

> And please make sure we simply skip the test if the feature is not
> configured. Might require some _CC_COBALT_GET_CAN_CONFIG (analogously to
> _CC_COBALT_GET_NET_CONFIG and kernel/drivers/net/stack/corectl.c).

Ok, I'll do it.

Thanks and regards,
Dario
> 
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux

