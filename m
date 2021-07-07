Date: Wed, 07 Jul 2021 17:19:20 +0000
From: Sylvan Williams <sylvan@voidptr.dev>
Reply-To: Sylvan Williams <sylvan@voidptr.dev>
Subject: Async DMA operations with Xenomai 3.1
Message-ID: <40BB3CA5-0698-44C5-9975-43179C812260@voidptr.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone,

I have some questions about which approach I should take to allow OOB execu=
tion of DMA completion handlers when running kernel 4.14.110 + IPipe + Xeno=
mai 3.1.

The system is a Zynq (dual ARM Cortex A-9), and I have a UDD driver which r=
egisters a hardware GPIO interrupt that=E2=80=99s incoming from the FPGA. T=
he UDD driver also performs mmap=E2=80=99ing of some memory regions that ar=
e mapped to DMA, and those regions are submitted to the dmaengine for trans=
fer into FPGA block RAM inside the interrupt handler of the UDD driver. The=
 DMA controller also has an interrupt which is tied into the GIC to signal =
the completion of an operation

This works, for a while, but eventually I end up with a system hang that I=
=E2=80=99m (guessing) is due to deadlock between the head and root stages f=
or calling the completion handler inside the xilinx-dma driver.

I stumbled upon the EVL project and Dovetail just last week, and it appears=
 Dovetail addresses this issue with the introduction of the IRQF_OOB flag. =
I=E2=80=99m in the process of attempting to add the same functionality to I=
Pipe, but now I=E2=80=99m looking for advice for the best approach since I =
feel like I=E2=80=99m about to get myself into a pretty intense code tangle=
.

So my question is:
Should I continue with this approach? or
Scrap it, and create an RTDM version of the xilinx DMA driver?
Is there an easier approach I haven=E2=80=99t thought of?

For more context, below is a snippet of the DMA transaction which is called=
 from the udd_device.handler. Again, I believe the problem lies in the fact=
 dmaengine_submit() and dma_async_issue_pending are called from OOB context=
, while the completion handler inside the xilinx DMA driver needs to run on=
 receipt of the hardware interrupt from the DMA controller.

Also, this is a closed system, so the solution doesn=E2=80=99t necessarily =
have/need to fit into the kernel in an upstreamable fashion, if that makes =
sense.

There=E2=80=99s also the possibility that I=E2=80=99m completely incorrect =
in my theory, so no harm in pointing that out if it=E2=80=99s the case.

Any advice will be much appreciated!

Thanks,

Sylvan


static int dma_tx(fermi_tx_buf_t buf)
{
    int err;
    struct dma_async_tx_descriptor* txd;
    dma_addr_t dma_handle_src;
    dma_addr_t dma_handle_dest;
    size_t transaction_len;
    int active_bank;

    /* The MSB of the BRAM address bus is connected to the EMIO interface o=
f the processor.
       Reading the value will indicate which half of the BRAM buffer is cur=
rently being written
       to the CV DAC array. Transfers need to occur into the _inactive_ buf=
fer. Read the value
       add set the destination address accordingly
    */
    active_bank =3D gpio_get_value(zynq_emio_active_bank);

    /* MSB high - transfer to low buffer */
    if (active_bank =3D=3D true)
    {
        dma_handle_dest =3D (dma_addr_t)soundengine_params_dest_addr;
    }
    /* MSB low - transfer to high buffer */
    else
    {
        dma_handle_dest =3D (dma_addr_t)(soundengine_params_dest_addr + sou=
ndengine_buf_len);
    }

    /* Set DDR RAM source address and transaction length depending on the v=
alue passed through the ioctl */
    if (buf =3D=3D BUF_A)
    {
        transaction_len =3D fermi_platform_dev->tx.transaction_len;
        dma_handle_src =3D dma_map_single(fermi_platform_dev->tx.chan->devi=
ce->dev, fermi_platform_dev->tx.dma_buf_src, transaction_len, DMA_TO_DEVICE=
);
    }
    else if (buf =3D=3D BUF_B)
    {
        transaction_len =3D fermi_platform_dev->tx.transaction_len;
        dma_handle_src =3D dma_map_single(fermi_platform_dev->tx.chan->devi=
ce->dev,
                                                         (void*)((uint8_t*)=
fermi_platform_dev->tx.dma_buf_src + soundengine_buf_len), transaction_len,=
 DMA_TO_DEVICE);
    }
    else
    {
        dev_err(&fermi_platform_dev->pdev->dev, "Cyclic TX DMA - unknown ar=
gument!\n");
        goto fail;
    }

    fermi_platform_dev->tx.transaction_addr =3D dma_handle_src;
    fermi_platform_dev->tx.transaction_len =3D transaction_len;
    reinit_completion(&fermi_platform_dev->tx.cmd_complete);

    txd =3D dmaengine_prep_dma_memcpy(fermi_platform_dev->tx.chan, dma_hand=
le_dest, dma_handle_src, transaction_len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK=
);

    if (!txd)
    {
        dev_err(&fermi_platform_dev->pdev->dev, "Unable to prepare cyclic T=
X DMA transaction!\n");
        //dmaengine_terminate_all(fermi_platform_dev->tx.chan);
        err =3D -ENOMEM;
        goto fail;
    }

    txd->callback =3D tx_dma_callback;
    txd->callback_param =3D &fermi_platform_dev->tx;

    dmaengine_submit(txd);
    dma_async_issue_pending(fermi_platform_dev->tx.chan);

    return 0;

fail:
    return err;
}




