Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mlJlOiDlm57lpI3vvJpSZTog5Zue5aSN77yaUmU6?=
 =?UTF-8?Q?_Xenomai_latency=5ftest=5fnot=5fgood?=
References: <20190909125657.AFA5016600E9@webmail.sinamail.sina.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <41bd3db7-0052-851d-bd05-574af5499dfb@siemens.com>
Date: Mon, 9 Sep 2019 15:56:37 +0200
MIME-Version: 1.0
In-Reply-To: <20190909125657.AFA5016600E9@webmail.sinamail.sina.com.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hikwlu@sina.com, xenomai <xenomai@xenomai.org>

On 09.09.19 14:56, 鲁克文 wrote:
> Dear Jan:
> 
> For the graphic thing, our system really needs graphic, it could not be removed. 
> Otherwise, I saw articles that someone got very low latency also in some X86 
> ubuntu-desktop version, so I wonder whether the graphic is the key factor to the 
> realtime system.

Every system is different. And graphic != graphic (only framebuffer, GPU 
acceleration etc.).

> 
> For your second point: "Try that with a vanilla kernel on your hardware."  You 
> mean I can use the hardware latency detector to test my kernel?
> 

The hardware latency detector tests the hardware. But this feature is not 
supported by the I-pipe kernel, therefore use a vanilla one.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

