Message-ID: <0247b98d-5768-96cb-3a87-2cc3e88e2d89@siemens.com>
Date: Sat, 23 Apr 2022 19:26:40 +0200
Subject: Re: [PATCH v2] utils/net/rtnet.in: add delay during master
 configuration
Content-Language: en-US
References: <7de1b93d-4feb-20a6-9204-6c8eddd0fa17@tin.it>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <7de1b93d-4feb-20a6-9204-6c8eddd0fa17@tin.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mauro S." <mau.salvi@tin.it>, xenomai@xenomai.org

Hi all,

some minor comments, see below:

On 22.04.22 20:58, Mauro S. via Xenomai wrote:
> Some cards are slow to get the connection link up after the
> "rtifconfig rteth0 up" command, e.g. on an Atom-x5 with an Intel I210
> (rt_igb driver) I detected approximately 3 seconds to get the link up.
> 
> On master, the "rtifconfig rteth0 up" is followed by TDMA configuration and
> start. After the TDMA start, the sync packet is sent at the defined
> cycle time.
> 
> Sometimes, after "rtnet start", the dmesg fills with this error:
> 
>   TDMA: Failed to transmit sync frame!
> 
> and the rt driver locks. Then, the kernel watchdog is triggered and the
> NIC is hw-reset by the kernel, producing more errors and another lock.
> Sometimes the dmesg only fills with the error message and the NIC does
> not lock.
> This happens because the interface is not up and ready to handle
> the sync packets when TDMA is started.
> 
> This patch introduces a configurable delay between the "rtifconfig
> rteth0 up"
> and the TDMA start on master host. This allows to avoid these kind of
> problems.
> 
> Signed-off-by: Mauro Salvini <mau.salvi@tin.it>
> ---
>  utils/net/rtnet.in | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/utils/net/rtnet.in b/utils/net/rtnet.in
> index f81a7bb0a..8c2dcdf6e 100644
> --- a/utils/net/rtnet.in
> +++ b/utils/net/rtnet.in
> @@ -15,15 +15,19 @@ debug_func() {
>  usage() {
>      cat << EOF
>  Usage:
> -    $0 [-cf <config-file>] [-v] [-c] {start|stop}
> +    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] {start|stop}
>      Start or stop station according to configuration file
> 
> -    $0 [-cf <config-file>] [-v] [-c] master <slave_ip1> [<slave_ip2> ...]
> +    $0 [-cf <config-file>] [-d <delay>] [-v] [-c] master <slave_ip1>
> [<slave_ip2> ...]
>      Start station as master for given list of slaves
> 
>      $0 [-cf <config-file>] [-v] capture
>      Start only passive realtime capturing
> 
> +    The parameter -d allows to introduce a delay in seconds between the
> +    "rtifconfig rtethX up" command and the TDMA start on the host
> +    configured as master. Useful to avoid errors/card locks when the
> +    RT NIC is slow to get the link up.
>      The additional switch -v enables verbose output.
>      The additional switch -c enables capturing mode to allow use of a
> network
>      analyzer such as Wireshark (if rtnet was built with --enable-rtcap).
> @@ -76,6 +80,10 @@ submit_cfg() {
>      master)
>          $RTIFCONFIG rteth0 up $STATION_IP
> 
> +        if [ -n "$UPDELAY" ]; then

Checked with shellcheck? I would expect ${UPDELAY} here and below.

> +        sleep $UPDELAY

Indention looks broken.

> +        fi
> +
>          $TDMACFG rteth0 master $TDMA_CYCLE
>          eval "$TDMA_SLOTS"
> 
> @@ -144,6 +152,10 @@ start_master() {
> 
>      $RTIFCONFIG rteth0 up $IPADDR $NETMASK_OPT
> 
> +    if [ -n "$UPDELAY" ]; then
> +        sleep $UPDELAY
> +    fi
> +
>      $TDMACFG rteth0 master $TDMA_CYCLE
>      $TDMACFG rteth0 slot 0 0
> 
> @@ -258,6 +270,11 @@ else
>      exit 1
>  fi
> 
> +if [ "$1" = "-d" ]; then
> +    UPDELAY="$2"
> +    shift 2
> +fi
> +
>  if [ "$1" = "-v" ]; then
>      echo "Turning on verbose mode"
>      RTIFCONFIG="debug_func $RTIFCONFIG"


