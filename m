References: <1488597983336.36220@kth.se> <1488601846543.4195@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c7c077da-ea23-899a-6886-9543ce11fbb0@xenomai.org>
Date: Sun, 5 Mar 2017 16:46:16 +0100
MIME-Version: 1.0
In-Reply-To: <1488601846543.4195@kth.se>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Latency test fails after in a Xenomai patched Ostro
 XT linux distro - part 2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nitin Kulkarni <nitink@kth.se>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/04/2017 05:30 AM, Nitin Kulkarni wrote:
> After the below things happened I added a regular user (nitin) to the allowed_group parameter file in /sys/module/xenomai/parameters/allowed_group
> 
> 
> Then executed the latency test to get this message :
> 
> 
> nitin@intel-corei7-64:/usr/bin$ /usr/xenomai/bin/latency
>    0"000.000| WARNING: [main] cannot open RTDM device /dev/rtdm/memdev-private: Permission denied
>    0"000.000| WARNING: [main] cannot map private umm area: Permission denied
>    0"000.000| BUG in init_bind(): [main] (CONFIG_DEVTMPFS_MOUNT not enabled?)
> 
> ?I must be doing something wrong. Please let me know.

You need to tell udev to set appropriate permissions to the RTDM devices
via some rule file, so that users from this group may access those
devices, e.g.

# Xenomai real-time devices
SUBSYSTEM=="rtdm", MODE="0660", GROUP=<your-group>

-- 
Philippe.

