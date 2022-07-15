import matlab.engine


def cool():
    eng = matlab.engine.start_matlab()
    eng.heatmap_gen1(nargout=0)
    eng.quit()


def hot():
    eng = matlab.engine.start_matlab()
    eng.Hemoglobin_quantification(nargout=0)
    eng.quit()
