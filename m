Message-ID: <1530603625.4507.9.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Tue, 03 Jul 2018 09:40:25 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [rtcan] Access to tx / rx / err counters
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi,

/proc/rtcan/devices , as well as the respective
/proc/rtcan/<device>/info both gives access to the TX-Counter, RX-
Counter and Errors counter of the device.

I'd like to access these counters from an application, but cannot find
the appropriate ioctls to do this. Adding them is not an issue, but i
would like to avoid duplicating any existing feature, or to read the
/proc filesystem whose format is not really guaranted.

Is there a way to access these counters ? And if not, what would be the
ioctl to add ? For example :

#define RTCAN_RTIOC_GET_RXCOUNTER _IOR(RTIOC_TYPE_CAN, 0xC, int)
#define RTCAN_RTIOC_GET_TXCOUNTER _IOR(RTIOC_TYPE_CAN, 0xD, int)
#define RTCAN_RTIOC_GET_ERRCOUNTER _IOR(RTIOC_TYPE_CAN, 0xE, int)

Regards,

Julien

