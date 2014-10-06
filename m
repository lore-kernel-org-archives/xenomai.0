Message-ID: <54328CBA.7040005@sigmatek.at>
Date: Mon, 06 Oct 2014 14:36:10 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] rtserial bug 16550 + imx
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

is this correct, that the ioctl RTSER_RTIOC_GET_STATUS does not return
the correct rtser_status.
Because rxbuf_status and txbuf_status was not filled into rtser_status structure.

i've add
      status_buf.rxbuf_status = ctx->in_npend;
      status_buf.txbuf_status = ctx->out_npend;
and also in the else block.

is this correct ?

Thanks
Best regards
   Johann




